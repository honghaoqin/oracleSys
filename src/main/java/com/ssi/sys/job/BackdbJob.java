package com.ssi.sys.job;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;
import com.ssi.framework.spring.SpringUtils;
import com.ssi.sys.service.BackupService;
public class BackdbJob implements StatefulJob , Serializable{
	
	private static final long serialVersionUID = -1370802501188396628L;
	
	public void execute(JobExecutionContext context) throws JobExecutionException {
		BackupService backupService = SpringUtils.getBean(BackupService.class);
		try {
			backupService.beiFen(new HashMap());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
