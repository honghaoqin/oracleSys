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
		String job_id = ObjectUtils.toString(jobMap.get(JobDao.JOB_ID));// 主键
		String cls = ObjectUtils.toString(jobMap.get(JobDao.CLS));// 类
		String des = ObjectUtils.toString(jobMap.get(JobDao.DES));// 描述

		String durability = ObjectUtils.toString(jobMap.get(JobDao.DURABILITY));// DURABILITY
		String volatility = ObjectUtils.toString(jobMap.get(JobDao.VOLATILITY));// VOLATILITY
		String recover = ObjectUtils.toString(jobMap.get(JobDao.RECOVER));// SHOULDRECOVER

		String expression = ObjectUtils.toString(jobMap.get(JobDao.EXPRESSION));// 表达式
		String start_time = ObjectUtils.toString(jobMap.get(JobDao.START_TIME));// 开始时间
		String end_time = ObjectUtils.toString(jobMap.get(JobDao.END_TIME));// 结束时间
		// 类
		Class jobClass = null;
		try {
			jobClass = Class.forName(cls);
		} catch (ClassNotFoundException e2) {
			e2.printStackTrace();
			throw new BusinessException("找不到定时任务类"+e2);
		}

		// ----------------------- JobDetail

		JobDetail jobDetail = new JobDetail(job_id, jobClass);
		
		//
		jobDetail.setDurability("1".equals(durability));
		jobDetail.setVolatility("1".equals(volatility));
		jobDetail.setRequestsRecovery("1".equals(recover));

		addJob(jobDetail);//add
		// Trigger和Calendar(如有多个Calendar就组成链)。

		// 开始时间
		Date start = null;
		if (StringUtils.isNotEmpty(start_time)) {
			try {
				start = dtFormat.parse(start_time);
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException("格式化开始时间出错"+e.getMessage());
			}
		}
		// 结束时间
		Date end = null;
		if (StringUtils.isNotEmpty(end_time)) {
			try {
				end = dtFormat.parse(end_time);
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException("格式化开始时间出错"+e.getMessage());
			}
		}

		CronExpression cronExpression = null;
		try {
			cronExpression = new CronExpression(expression);
		} catch (Exception e) {
			throw new BusinessException("定时任务触发器表达式不正确:"+e.getMessage());
		}

		// ----------------------- cron
		CronTrigger cronTrigger = new CronTrigger(SchedulerUtils.getTriggerName(job_id));
		cronTrigger.setCronExpression(cronExpression);

		cronTrigger.setJobName(jobDetail.getName());// 绑定Job

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
		BaseCalendar baseCalendar = null;// 组成链
		for (int i = 1; i <= 10; i++) {
			String key = "CAL" + i;
			String calendarExpression = ObjectUtils.toString(jobMap.get(key));// 表达式
			if (StringUtils.isEmpty(calendarExpression)) {
				continue;
			}
			CronCalendar cronCalendar;
			try {
				cronCalendar = new CronCalendar(baseCalendar, calendarExpression);
			} catch (ParseException e) {
				throw new BusinessException("定时任务触发器" + key + "表达式不正确:"+e.getMessage());
			}

			cronCalendar.setDescription(cronTrigger.getName() + key);// TODO
																		// 这里暂时用description来记录Calendar
																		// Name

			baseCalendar = cronCalendar;// 组成链
			
			addCalendar(cronTrigger.getName() + key, cronCalendar);//add

		}

		// CronTrigger排除CronCalendar
		if (baseCalendar != null) {
			cronTrigger.setCalendarName(baseCalendar.getDescription());// TODO
																		// 这里暂时用description来记录Calendar
																		// Name
		}
		
		return jobDetail;

	}
	/**
	 * 增加任务
	 * @param jobDetail
	 */
	public static void addJob(JobDetail jobDetail) {
		try {
			getScheduler().addJob(jobDetail, true);
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("增加任务失败:"+e.getMessage());
		}
	}
	/**
	 * 增加calendar
	 * @param name
	 * @param calendar
	 */
	public static void addCalendar(String name,Calendar calendar) {
		try {
			getScheduler().addCalendar(name, calendar, true, true);//add
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("增加Calendar失败:"+e.getMessage());
		}
	}
	/**
	 * 撤掉任务
	 * @param jobName
	 */
	public static void unscheduleJob(String jobName) {
		try {
			getScheduler().unscheduleJob(getTriggerName(jobName), Scheduler.DEFAULT_GROUP);
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("撤掉任务失败:"+e.getMessage());
		}
	}
	/**
	 * 更新Job
	 * @param jobName
	 */
	public static void rescheduleJob(String jobName) {
		try {
			getScheduler().rescheduleJob(getTriggerName(jobName), Scheduler.DEFAULT_GROUP, getTrigger(jobName));
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("更新任务失败:"+e.getMessage());
		}
	}
	/**
	 * 安排任务
	 * @param jobName
	 */
	public static void scheduleJob(String jobName) {
		scheduleJob(getTrigger(jobName));
	}
	/**
	 * 安排任务
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
			throw new BusinessException("安排任务失败:"+e.getMessage());
		}
	}
	/**
	 * 删除任务
	 * @param jobName
	 */
	public static void deleteJob(String jobName) {
		try {
			getScheduler().deleteJob(jobName, Scheduler.DEFAULT_GROUP);
		} catch (SchedulerException e) {
			e.printStackTrace();
			throw new BusinessException("删除任务失败:"+e.getMessage());
		}
	}
	
}
