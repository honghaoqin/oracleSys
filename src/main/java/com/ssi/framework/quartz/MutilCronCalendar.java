package com.ssi.framework.quartz;

import java.util.Date;

import org.quartz.Calendar;
import org.quartz.CronExpression;
import org.quartz.impl.calendar.BaseCalendar;

public class MutilCronCalendar extends BaseCalendar {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4407865203917738445L;
	

    CronExpression[] cronExpressions;
    
    public MutilCronCalendar(CronExpression[] cronExpressions){
        this(null, cronExpressions);
    }

    public MutilCronCalendar(Calendar baseCalendar,
    		CronExpression[] cronExpressions){
        super(baseCalendar);
        this.cronExpressions = cronExpressions;
    }
    
    @Override
    public Object clone() {
    	MutilCronCalendar clone = (MutilCronCalendar) super.clone();
        clone.cronExpressions = (CronExpression[]) cronExpressions.clone();
        return clone;
    }

    @Override
    public boolean isTimeIncluded(long timeInMillis) {        
        if ((getBaseCalendar() != null) && 
                (getBaseCalendar().isTimeIncluded(timeInMillis) == false)) {
            return false;
        }
        
        if(cronExpressions!=null){
        	Date date = new Date(timeInMillis);
        	for(CronExpression cronExpression : cronExpressions){
        		if(cronExpression.isSatisfiedBy(date)){
        			return false;
        		}
        	}
        }
        
        return true;
    }

    @Override
    public long getNextIncludedTime(long timeInMillis) {
        long nextIncludedTime = timeInMillis + 1; //plus on millisecond
        
        while (!isTimeIncluded(nextIncludedTime)) {
        	
        	CronExpression satisfiledCronExpression = null;
        	if(cronExpressions!=null){
            	Date date = new Date(nextIncludedTime);
            	for(CronExpression cronExpression : cronExpressions){
            		if(cronExpression.isSatisfiedBy(date)){
            			satisfiledCronExpression = cronExpression;
            			break;
            		}
            	}
            }
        	
            if (satisfiledCronExpression!=null) {
                nextIncludedTime = satisfiledCronExpression.getNextInvalidTimeAfter(
                        new Date(nextIncludedTime)).getTime();
            } else if ((getBaseCalendar() != null) && 
                    (!getBaseCalendar().isTimeIncluded(nextIncludedTime))){
                nextIncludedTime = 
                    getBaseCalendar().getNextIncludedTime(nextIncludedTime);
            } else {
                nextIncludedTime++;
            }
        }
        
        return nextIncludedTime;
    }

    @Override
    public String toString() {
        StringBuffer buffer = new StringBuffer();
        buffer.append("base calendar: [");
        if (getBaseCalendar() != null) {
            buffer.append(getBaseCalendar().toString());
        } else {
            buffer.append("null");
        }
        buffer.append("], excluded cron expression: '");
        buffer.append(cronExpressions.toString());
        buffer.append("'");
        return buffer.toString();
    }
    
    public CronExpression[] getCronExpressions() {
        return cronExpressions;
    }
    
}
