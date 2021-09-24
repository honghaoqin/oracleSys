package com.ssi.sys.job;

import java.io.Serializable;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.ssi.framework.spring.SpringUtils;
import com.ssi.sys.service.ClearLogJobService;

public class ClearLogJob  implements Job,Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3685103278657217515L;

	public void execute(JobExecutionContext context) throws JobExecutionException {
		ClearLogJobService clearLogJobService = SpringUtils.getBean(ClearLogJobService.class);
		clearLogJobService.run();
	}

}
