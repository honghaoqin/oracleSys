package com.ssi.framework.quartz;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Calendar;
import org.quartz.CronExpression;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.calendar.BaseCalendar;
import org.quartz.impl.calendar.CronCalendar;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import com.ssi.framework.spring.SpringUtils;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.JobDao;

public class JdbcSchedulerFactoryBean extends SchedulerFactoryBean {

	protected final Log LOG = LogFactory.getLog(getClass());

	private JobDetail[] jobDetails;

	private Map<String, Calendar> calendars;

	private Trigger[] triggers;

	private static final SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	

	public void setQrtzDataSource(DataSource qrtzDataSource) {
		super.setDataSource(qrtzDataSource);
	}	
	
	@Override
	public void setDataSource(DataSource dataSource) {
		//RAMJobStore 时屏蔽掉 setDataSource。JdbcJobStore时请使用setQrtzDataSource
	}
	
	@Override
	protected void registerJobsAndTriggers() throws SchedulerException {
		//记录Scheduler
		SchedulerUtils.setScheduler(this.getScheduler());
		// 从数据库中注册
		this.registerJobsAndTriggersFromJdbc();
		// 从配置文件中注册
		super.registerJobsAndTriggers();
	}

	@Override
	public void setJobDetails(JobDetail[] jobDetails) {
		this.jobDetails = jobDetails;
		super.setJobDetails(jobDetails);
	}

	@Override
	public void setCalendars(Map<String, Calendar> calendars) {
		this.calendars = calendars;
		super.setCalendars(calendars);
	}

	@Override
	public void setTriggers(Trigger[] triggers) {
		this.triggers = triggers;
		super.setTriggers(triggers);
	}
	protected void registerJobsAndTriggersFromJdbc() throws SchedulerException {
		
//		this.setOverwriteExistingJobs(true);//测试
		
		JobDao jobDao = SpringUtils.getBean(JobDao.class);
		
		Map jobQueryMap = new HashMap();
		SqlUtis.prepareSql(jobQueryMap, 
				" and a.ISSTART='1' and a.cls is not null and a.EXPRESSION is not null and (a.START_TIME is null or a.START_TIME < sysdate) and (a.END_TIME is null or a.END_TIME < sysdate)"
				);
		List<Map> jobList = jobDao.list(jobQueryMap);// 查出所有定时任务
		if (jobList == null || jobList.isEmpty()) {
			return;
		}

		List<JobDetail> jdbcJobDetails = new ArrayList<JobDetail>();
		Map<String, Calendar> jdbcCalendars = new HashMap<String, Calendar>();
		List<Trigger> jdbcTriggers = new ArrayList<Trigger>();

		for (Map jobMap : jobList) {
			if (jobMap == null || jobMap.isEmpty()) {
				continue;
			}
			String job_id = ObjectUtils.toString(jobMap.get(JobDao.JOB_ID));// 主键
			String cls = ObjectUtils.toString(jobMap.get(JobDao.CLS));// 类
			String des = ObjectUtils.toString(jobMap.get(JobDao.DES));// 描述

			String durability = ObjectUtils.toString(jobMap.get(JobDao.DURABILITY));// DURABILITY
			String volatility = ObjectUtils.toString(jobMap.get(JobDao.VOLATILITY));// VOLATILITY
			String recover = ObjectUtils.toString(jobMap.get(JobDao.RECOVER));// SHOULDRECOVER

			String expression = ObjectUtils.toString(jobMap.get(JobDao.EXPRESSION));// 表达式
			String start_time = ObjectUtils.toString(jobMap.get(JobDao.START_TIME));// 开始时间
			String end_time = ObjectUtils.toString(jobMap.get(JobDao.END_TIME));// 结束时间
			
			String isStart = ObjectUtils.toString(jobMap.get(JobDao.ISSTART));// 启动
			
			if (!"1".equals(isStart)) {
				continue;
			}
			// 类
			Class jobClass = null;
			try {
				jobClass = Class.forName(cls);
			} catch (ClassNotFoundException e2) {
				LOG.error("找不到定时任务类" + jobMap);
				e2.printStackTrace();
				throw new RuntimeException(e2);
			}

			// ----------------------- JobDetail

			JobDetail jobDetail = new JobDetail(job_id, jobClass);
			
			//
			jobDetail.setDurability("1".equals(durability));
			jobDetail.setVolatility("1".equals(volatility));
			jobDetail.setRequestsRecovery("1".equals(recover));

			jdbcJobDetails.add(jobDetail);// add

			// Trigger和Calendar(如有多个Calendar就组成链)。

			// 开始时间
			Date start = null;
			if (StringUtils.isNotEmpty(start_time)) {
				try {
					start = dtFormat.parse(start_time);
				} catch (Exception e) {
					LOG.error("格式化开始时间出错" + jobMap);
					e.printStackTrace();
					throw new RuntimeException(e);
				}
			}
			// 结束时间
			Date end = null;
			if (StringUtils.isNotEmpty(end_time)) {
				try {
					end = dtFormat.parse(end_time);
				} catch (Exception e) {
					LOG.error("格式化结束时间出错" + jobMap);
					e.printStackTrace();
					throw new RuntimeException(e);
				}
			}

			CronExpression cronExpression = null;
			try {
				cronExpression = new CronExpression(expression);
			} catch (Exception e) {
				LOG.error("定时任务触发器表达式不正确:" + jobMap.toString());
				throw new RuntimeException(e);
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

			jdbcTriggers.add(cronTrigger);// add

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
					LOG.error("定时任务触发器" + key + "表达式不正确:" + jobMap.toString());
					throw new RuntimeException(e);
				}

				cronCalendar.setDescription(cronTrigger.getName() + key);// TODO
																			// 这里暂时用description来记录Calendar
																			// Name

				baseCalendar = cronCalendar;// 组成链

				jdbcCalendars.put(cronTrigger.getName() + key, cronCalendar);// add
			}

			// CronTrigger排除CronCalendar
			if (baseCalendar != null) {
				cronTrigger.setCalendarName(baseCalendar.getDescription());// TODO
																			// 这里暂时用description来记录Calendar
																			// Name
			}
		}

		// 1.合并 JobDetail
		JobDetail[] newJobDetails = new JobDetail[(this.jobDetails == null ? 0 : this.jobDetails.length) + jdbcJobDetails.size()];
		int ind = 0;
		// 优先数据库
		for (JobDetail e : jdbcJobDetails) {
			newJobDetails[ind++] = e;
		}
		// 配置文件
		if (this.jobDetails != null) {
			for (JobDetail e : this.jobDetails) {
				newJobDetails[ind++] = e;
			}
		}
		// 设置
		super.setJobDetails(newJobDetails);

		// 2.合并 Calendar
		if (this.calendars == null || this.calendars.isEmpty()) {
			this.calendars = jdbcCalendars;
		} else {
			this.calendars.putAll(jdbcCalendars);
		}

		// 设置
		super.setCalendars(this.calendars);

		// 3.合并 Trigger
		Trigger[] newTriggers = new Trigger[(this.triggers == null ? 0 : this.triggers.length) + jdbcTriggers.size()];
		ind = 0;
		// 优先数据库
		for (Trigger e : jdbcTriggers) {
			newTriggers[ind++] = e;
		}
		// 配置文件
		if (this.triggers != null) {
			for (Trigger e : this.triggers) {
				newTriggers[ind++] = e;
			}
		}
		// 设置
		super.setTriggers(newTriggers);
	}

}
