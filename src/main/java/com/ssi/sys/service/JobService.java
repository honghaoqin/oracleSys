 /*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;
import java.sql.Types;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.quartz.SchedulerUtils;
import com.ssi.framework.service.BaseService;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.DeptDao;
import com.ssi.sys.dao.FileDao;
import com.ssi.sys.dao.JobDao;
/**
 * 定时任务
 */
@Service
public class JobService extends BaseService{
	@Autowired
	JobDao jobDao;
	/**
	 * 
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
		String jobName =jobDao.UUID();
		map.put(JobDao.JOB_ID, jobName);
		this.jobDao.insert(map);
		boolean isStart = "1".equals(map.get(JobDao.ISSTART));
		if (isStart) {
			SchedulerUtils.createJobDetail(map);
			SchedulerUtils.scheduleJob(jobName);
		}
		return jobName;
	}
	
	/**
	 * 删除job
	 * @param map
	 */
	@Transactional
	public void delete(Map map) {
		SqlUtis.prepareSql(map
				,SqlUtis.getSQLRequired(map,"a."+JobDao.JOB_ID,Types.VARCHAR,SqlUtis.EQ)
			);
		this.jobDao.delete(map);
		map.remove(SqlUtis.WHERE_SQL);
		
		String jobNames = (String) map.get(JobDao.JOB_ID);
		String[] jobNameArr = jobNames.split(",");
		for (int i = 0; i < jobNameArr.length; i++) {
			String jobName = jobNameArr[i].trim();
			SchedulerUtils.unscheduleJob(jobName);
			SchedulerUtils.deleteJob(jobName);
		}
	}
	/**
	 * 更新job
	 * @param map
	 */
	@Transactional
	public void update(Map map) {
		SqlUtis.prepareSql(map,""
				,SqlUtis.getSQLRequired(map,"a."+JobDao.JOB_ID,Types.VARCHAR,SqlUtis.EQ)
			);
		this.jobDao.update(map);
		map.remove(SqlUtis.WHERE_SQL);
		
		String jobName = (String) map.get(JobDao.JOB_ID);
		SchedulerUtils.unscheduleJob(jobName);
		SchedulerUtils.deleteJob(jobName);
		boolean isStart = "1".equals(map.get(JobDao.ISSTART));
		if (isStart) {
			SchedulerUtils.createJobDetail(map);
			SchedulerUtils.scheduleJob(jobName);
		}
	}
	
	
	
	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map,"a."+JobDao.JOB_ID,Types.VARCHAR,SqlUtis.EQ));
		Object obj = this.jobDao.one(map);
		map.remove(SqlUtis.WHERE_SQL);
		return obj;
	}
	
	
	/**
	 * 分页查询结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map, Page page) {
		SqlUtis.prepareSql(map,SqlUtis.getSQL(map, "a." + JobDao.DES, Types.VARCHAR, SqlUtis.LIKE)
		, SqlUtis.orderBy(" a." + JobDao.CREATED_DATE + " DESC"));
		List<Map> list = this.jobDao.list(map, page);
		if(list !=null && !list.isEmpty()){
			for (int i=0;i<list.size();i++) {
				Map jobMap = list.get(i);
				String jobName =ObjectUtils.toString(jobMap.get(JobDao.JOB_ID));
				String state = SchedulerUtils.getTriggerStateDes(jobName);
				Date nextFireTime = SchedulerUtils.getNextFireTime(jobName);
				jobMap.put("STATE", state);
				if(nextFireTime!=null){
					jobMap.put("NEXTFIRETIME", DateFormatUtils.format(nextFireTime, "yyyy-MM-dd HH:mm:ss"));
				}
			}
		}
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	
	
	
    /**
     * 停止job
     * @param map
     */
	@Transactional
	public void stop(Map map) {
		String jobName =ObjectUtils.toString(map.get(JobDao.JOB_ID));
		//isStart=0
		Map updateMap = new HashMap();
		updateMap.put(JobDao.JOB_ID, jobName);
		updateMap.put(JobDao.ISSTART, "0");
		SqlUtis.prepareSql(updateMap
				,SqlUtis.getSQLRequired(updateMap,"a."+JobDao.JOB_ID,Types.VARCHAR,SqlUtis.EQ)
			);
		this.jobDao.update(updateMap);
		map.remove(SqlUtis.WHERE_SQL);
		
		SchedulerUtils.unscheduleJob(jobName);
	}
	/**
	 * 启动job
	 * @param map
	 */
	@Transactional
	public void start(Map map) {
        //更新job的状态值
		String jobName = (String) map.get(JobDao.JOB_ID);
		//isStart=1
		Map updateMap = new HashMap();
		updateMap.put(JobDao.JOB_ID, jobName);
		updateMap.put(JobDao.ISSTART, "1");
		SqlUtis.prepareSql(updateMap,SqlUtis.getSQLRequired(updateMap,"a."+JobDao.JOB_ID,Types.VARCHAR,SqlUtis.EQ));
		this.jobDao.update(updateMap);
		updateMap.remove(SqlUtis.WHERE_SQL);
		//启动job
		SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,"a."+JobDao.JOB_ID,Types.VARCHAR,SqlUtis.EQ));
		SchedulerUtils.createJobDetail((Map) this.one(map));
		map.remove(SqlUtis.WHERE_SQL);
		SchedulerUtils.scheduleJob(jobName);
	}
}

