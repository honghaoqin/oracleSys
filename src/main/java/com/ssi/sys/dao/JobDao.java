 /*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.ssi.framework.dao.BaseDao;
/**
 * 定时任务
 */
@Repository
public class JobDao extends BaseDao{
	public static final String NAMESPACE="S_JOB";
	public static final String JOB_ID="JOB_ID";//主键
	public static final String DES="DES";//描述
	public static final String CLS="CLS";//类
	public static final String START_TIME="START_TIME";//开始时间
	public static final String END_TIME="END_TIME";//结束时间
	public static final String DURABILITY="DURABILITY";//DURABILITY
	public static final String VOLATILITY="VOLATILITY";//VOLATILITY
	public static final String RECOVER="RECOVER";//RECOVER
	public static final String EXPRESSION="EXPRESSION";//表达式
	public static final String CAL1="CAL1";//排除1
	public static final String CAL2="CAL2";//排除2
	public static final String CAL3="CAL3";//排除3
	public static final String CAL4="CAL4";//排除4
	public static final String CAL5="CAL5";//排除5
	public static final String CAL6="CAL6";//排除6
	public static final String CAL7="CAL7";//排除7
	public static final String CAL8="CAL8";//排除8
	public static final String CAL9="CAL9";//排除9
	public static final String CAL10="CAL10";//排除10
	public static final String ISSTART="ISSTART";//启动
	public static final String UPDATED_BY="UPDATED_BY";//更新人
	public static final String UPDATED_DATE="UPDATED_DATE";//更新时间
	public static final String CREATED_DATE="CREATED_DATE";//创建时间
	public static final String CREATED_BY="CREATED_BY";//创建人
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
	
}

