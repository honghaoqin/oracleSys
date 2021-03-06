package com.ssi.framework.quartz;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.quartz.Calendar;
import org.quartz.CronExpression;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.ObjectAlreadyExistsException;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.calendar.BaseCalendar;
import org.quartz.impl.calendar.CronCalendar;

import com.ssi.framework.exceptions.BusinessException;
import com.ssi.sys.dao.JobDao;

public class SchedulerUtils {
	private static final SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	private static Scheduler instance = null;

	public static Scheduler getScheduler() {
		return instance;
	}

	public static void setScheduler(Scheduler scheduler) {
		instance = scheduler;
	}

	public static String getTriggerName(String jobName) {
		return jobName + "_trigger";
	}

	public static JobDetail getJobDetail(String jobName) throws SchedulerException {
		return getScheduler().getJobDetail(jobName, Scheduler.DEFAULT_GROUP);
	}

	public static Trigger getTrigger(String jobName) {
		try {
			return getScheduler().getTrigger(getTriggerName(jobName), Scheduler.DEFAULT_GROUP);
		} catch (SchedulerException e) {
			return null;
		}
	}

	public static int getTriggerState(String jobName){
		try {
			return getScheduler().getTriggerState(getTriggerName(jobName), Scheduler.DEFAULT_GROUP);
		} catch (SchedulerException e) {
			e.printStackTrace();
			return Trigger.STATE_NONE;
		}
	}
	public static String getTriggerStateDes(String jobName){
		int state = getTriggerState(jobName);
		switch (state) {
		case Trigger.STATE_BLOCKED:
			return "Blocked";
		case Trigger.STATE_COMPLETE:
			return "Complete";
		case Trigger.STATE_ERROR:
			return "Error";
		case Trigger.STATE_NONE:
			return "None";
		case Trigger.STATE_NORMAL:
			return "Normal";
		case Trigger.STATE_PAUSED:
			return "Paused";
		default:
			return "None";
		}
	}
	public static Date getNextFireTime(String jobName){
		Trigger trigger = getTrigger(jobName);
		if (trigger != null) {
			return trigger.getNextFireTime();
		}
		return null;
	}

	public static JobDetail createJobDetail(Map jobMap){
		String job_id = ObjectUtils.toString(jobMap.get(JobDao.JOB_ID));// ??????
		String cls = ObjectUtils.toString(jobMap.get(JobDao.CLS));// ???
		String des = ObjectUtils.toString(jobMap.get(JobDao.DES));// ??????

		String durability = ObjectUtils.toString(jobMap.get(JobDao.DURABILITY));// DURABILITY
		String volatility = ObjectUtils.toString(jobMap.get(JobDao.VOLATILITY));// VOLATILITY
		String recover = ObjectUtils.toString(jobMap.get(JobDao.RECOVER));// SHOULDRECOVER

		String expression = ObjectUtils.toString(jobMap.get(JobDao.EXPRESSION));// ?????????
		String start_time = ObjectUtils.toString(jobMap.get(JobDao.START_TIME));// ????????????
		String end_time = ObjectUtils.toString(jobMap.get(JobDao.END_TIME));// ????????????
		// ???
		Class jobClass = null;
		try {
			jobClass = Class.forName(cls);
		} catch (ClassNotFoundException e2) {
			e2.printStackTrace();
			throw new BusinessException("????????????????????????"+e2);
		}

		// ----------------------- JobDetail

		JobDetail jobDetail = new JobDetail(job_id, jobClass);
		
		//
		jobDetail.setDurability("1".equals(durability));
		jobDetail.setVolatility("1".equals(volatility));
		jobDetail.setRequestsRecovery("1".equals(recover));

		addJob(jobDetail);//add
		// Trigger???Calendar(????????????Calendar????????????)???

		// ????????????
		Date start = null;
		if (StringUtils.isNotEmpty(start_time)) {
			try {
				start = dtFormat.parse(start_time);
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException("???????????????????????????"+e.getMessage());
			}
		}
		// ????????????
		Date end = null;
		if (StringUtils.isNotEmpty(end_time)) {
			try {
				end = dtFormat.parse(end_time);
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException("???????????????????????????"+e.getMessage());
			}
		}

		CronExpression cronExpression = null;
		try {
			cronExpression = new CronExpression(expression);
		} catch (Exception e) {
			throw new BusinessException("???????????????????????????????????????:"+e.getMessage());
		}

		// ----------------------- cron
		CronTrigger cronTrigger = new CronTrigger(SchedulerUtils.getTriggerName(job_id));
		cronTrigger.setCronExpression(cronExpression);

		cronTrigger.setJobName(jobDetail.getName());// ??????Job

		if (start != null) {
			cronTrigger.setStartTime(start);
		}
		if (end != null) {
			cronTrigger.setEndTime(end);
		}
		if (StringUtils.isNotEmpty(des)) {
			cronTrigger.setDescription(des);
		}
		
		scheduleJob(cronTrigger);//add
		// ----------------------- calendar
		BaseCalendar baseCalendar = null;// ?????????
		for (int i = 1; i <= 10; i++) {
			String key = "CAL" + i;
			String calendarExpression = ObjectUtils.toString(jobMap.get(key));// ?????????
			if (StringUtils.isEmpty(calendarExpression)) {
				continue;
			}
			CronCalendar cronCalendar;
			try {
				cronCalendar = new CronCalendar(baseCalendar, calendarExpression);
			} catch (ParseException e) {
				throw new BusinessException("?????????????????????" + key + "??????????????????:"+e.getMessage());
			}

			cronCalendar.setDescription(cronTrigger.getName() + key);// TODO
																		// ???????????????description?????????Calendar
																		// Name

			baseCalendar = cronCalendar;// ?????????
			
			addCalendar(cronTrigger.getName() + key, cronCalendar);//add

		}

		// CronTrigger??????CronCalendar
		if (baseCalendar != null) {
			cronTrigger.setCalendarName(baseCalendar.getDescription());// TODO
																		// ???????????????description?????????Calendar
																		// Name
		}
		
		return jobDetail;

	}
	/**
	 * ????????????
	 * @param jobDetail
	 */
	public static void addJob(JobDetail jobDetail) {
		try {
			getScheduler().addJob(jobDetail, true);
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("??????????????????:"+e.getMessage());
		}
	}
	/**
	 * ??????calendar
	 * @param name
	 * @param calendar
	 */
	public static void addCalendar(String name,Calendar calendar) {
		try {
			getScheduler().addCalendar(name, calendar, true, true);//add
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("??????Calendar??????:"+e.getMessage());
		}
	}
	/**
	 * ????????????
	 * @param jobName
	 */
	public static void unscheduleJob(String jobName) {
		try {
			getScheduler().unscheduleJob(getTriggerName(jobName), Scheduler.DEFAULT_GROUP);
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("??????????????????:"+e.getMessage());
		}
	}
	/**
	 * ??????Job
	 * @param jobName
	 */
	public static void rescheduleJob(String jobName) {
		try {
			getScheduler().rescheduleJob(getTriggerName(jobName), Scheduler.DEFAULT_GROUP, getTrigger(jobName));
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("??????????????????:"+e.getMessage());
		}
	}
	/**
	 * ????????????
	 * @param jobName
	 */
	public static void scheduleJob(String jobName) {
		scheduleJob(getTrigger(jobName));
	}
	/**
	 * ????????????
	 * @param trigger
	 */
	public static void scheduleJob(Trigger trigger) {
		try {
			try {
				getScheduler().scheduleJob(trigger);
			}
			catch (ObjectAlreadyExistsException ex) {
				getScheduler().rescheduleJob(trigger.getName(), trigger.getGroup(), trigger);
			}
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("??????????????????:"+e.getMessage());
		}
	}
	/**
	 * ????????????
	 * @param jobName
	 */
	public static void deleteJob(String jobName) {
		try {
			getScheduler().deleteJob(jobName, Scheduler.DEFAULT_GROUP);
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("??????????????????:"+e.getMessage());
		}
	}
	
}
