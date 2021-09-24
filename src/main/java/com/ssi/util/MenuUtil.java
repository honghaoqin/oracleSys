package com.ssi.util;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;

import com.ssi.framework.utils.TreeUtils;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.service.AuthService;

public class MenuUtil {

	public  static  String handChildParam(Map auth) {
		String param = "";
		if (null != auth && !auth.isEmpty()) {
			List<Map> childList = (List) auth.get(TreeUtils.CHILD);
			if (null != childList && !childList.isEmpty()) {
				Map cmap = (Map) childList.get(0);
				param = handChildParam(cmap);
			} else {
				param = ObjectUtils.toString(auth.get("PARAM"), "");
			}
		}
		return param;
	}

	// 获取第一个子节点ID
	public static String getFirstChildId(List menuList) {
		String childId = "";
		if (null != menuList && !menuList.isEmpty()) {
			Map auth = (Map) menuList.get(0);
			if (null != auth && !auth.isEmpty()) {
				List<Map> childList = (List) auth.get(TreeUtils.CHILD);
				if (null != childList && !childList.isEmpty()) {
					Map cmap = (Map) childList.get(0);
					childId = ObjectUtils.toString(cmap.get("AUTH_ID"));
				} else {
					childId = ObjectUtils.toString(auth.get("AUTH_ID"), "");
				}
			}
		}
		return childId;
	}

	// 获取第一个最末级子节点
	public static String getChildParam(List menuList) {
		menuList = TreeUtils.tree(menuList, AuthDao.PARENT_ID,
				AuthDao.AUTH_ID);// 父子树形结构
		String param = "";
		if (null != menuList && !menuList.isEmpty()) {
			Map auth = (Map) menuList.get(0);
			System.out.println(auth.get("AUTH_ID"));
			param = handChildParam(auth);
		}
		return param;
	}
	
	public static StringBuffer getMenuHTML(List menuList, String firstMenu,
			String hreport_id, String ctx) {
		StringBuffer html = new StringBuffer();
		if (menuList == null || menuList.isEmpty()) {
			return html;
		}
		// 如果没有子菜单，不用显示左边的菜单栏
		if (menuList.size() == 1) {
			List<Map> childList = ((List) ((Map) menuList.get(0))
					.get(TreeUtils.CHILD));
			if (childList == null || childList.isEmpty()) {
				return html;
			}
		}
		html.append("<div class=\"pnlLeftFrame\" id=\"pnlLeftFrame\">");
		html.append("    <div class=\"pnlHead\">");
		html.append("       <div class=\"pnlHead_L\">");  
		html.append("          <div class=\"pnlHead_R\">");  
		html.append("             <div class=\"pnlHead_C\">");  
		html.append("                <div class=\"pnlTitle\" id=\"pnlLeftTitle\">系统管理</div>");  
		html.append("                  <div class=\"pnlTool\"></div>"); 
		html.append("                </div>");
		html.append("             </div>");  
		html.append("         </div>");
		html.append("      </div>");  
		html.append("    <div class=\"pnlBody\"> ");  
		html.append("       <div class=\"pnlContent\" id=\"scrDiv\">");  
		html.append("         <div style=\"+zoom:1;\">");  
		html.append("            <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"outlookBar normalBar\" id=\"outlookBar\">"); 	
		for (int i = 0; i < menuList.size(); i++) {
			Map auth = (Map) menuList.get(i);
			String  active="";
			if (null != auth && !auth.isEmpty()) {
			if(i==0){
				active="_active";
			}else{
				active="";
			}	
			html.append("                <tr><td class=\"outlookItemTd"+active+"\">");
			html.append("                       <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"outlookItem"+active+"\" id=\"outlookItem"+(i+1)+"\">");  
			html.append("                            <tr class=\"outlookHead\">");
			html.append("                               <td><div class=\"outlookTitle\"><span class=\"outlookSwitch\"></span><span class=\"outlookIcon iconReaded\"></span>"+ObjectUtils.toString(auth.get("NAME"))+"</div></td>");  
			html.append("                            </tr>");  
			html.append("                            <tr class=\"outlookBody\">");  
			html.append("                               <td><div class=\"outlookCont\">");  
			html.append("                                      <ul class=\"infoList navList\">"); 
			List<Map> childList = (List) auth.get(TreeUtils.CHILD);
			if (null!=childList&&!childList.isEmpty()) {
				for(int  j=0;j<childList.size();j++){
					Map  childMap=childList.get(j);
					if(null!=childMap&&!childMap.isEmpty()){
			html.append("                                         <li class=\"infoItem\" id=\"infoItem_"+(i+1)+"_"+(j+1)+"\">");
			html.append("                                           <div class=\"infoTitle navItem2\"><span class=\"navSwitch\"></span>");
			html.append("                                               <a onclick=\"loadright('"+ctx+ObjectUtils.toString(childMap.get("PARAM"))+"')\">"+ObjectUtils.toString(childMap.get("NAME"))+"</a>");
			html.append("                                           </div>");
			html.append("                                         </li>");			
						}
					}
			}
			html.append("                                      </ul>");  
			html.append("                                    </div>");  
			html.append("                                </td>");  
			html.append("                            </tr>");  
			html.append("                        </table>"); 
			html.append("                    </td>");
			html.append("                </tr>");  	
				
			}
		}

		html.append("           </table>");
		html.append("      </div>");  
		html.append("    </div>");  
		html.append("    <div class=\"pnlBody_B\">");  
		html.append("       <div class=\"pnlBody_BL\">");  
		html.append("          <div class=\"pnlBody_BR\">"); 
		html.append("             <div class=\"pnlBody_BC\"></div>");
		html.append("          </div>");  
		html.append("       </div>"); 
		html.append("   </div>");
		html.append(" </div>");  
		html.append("</div>");          
        return html;
	}
	
	
	
	
	public static StringBuffer getMenuHTML2(List menuList, String firstMenu,String  hreport_id,String  ctx) {
		StringBuffer html = new StringBuffer();
		if (menuList == null || menuList.isEmpty()) {
			return html;
		}
		//如果没有子菜单，不用显示左边的菜单栏
		if(menuList.size() == 1){
			List<Map> childList = ((List) ((Map)menuList.get(0)).get(TreeUtils.CHILD));
			if (childList == null || childList.isEmpty()) {
				return html;
			}
		}
		
		for(int  i=0;i<menuList.size();i++){
			Map auth=(Map)menuList.get(i);
			if(null!=auth&&!auth.isEmpty()){
				html.append("<tr>").append("\n\t");
				html.append("  <td class=\"outlookItemTd_active\">").append("\n\t");
				//一级的菜单   普通状态：outlookItem   激活状态：outlookItem_active
				
				//html.append("     <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"outlookItem\" id=\"outlookItem"+(i+1)+"\">").append("\n\t");
				html.append("     <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"outlookItem\" id=\""+ObjectUtils.toString(auth.get("AUTH_ID"))+"\">").append("\n\t");
				html.append("        <tr class=\"outlookHead\">").append("\n\t");
				html.append("             <td><div class=\"outlookTitle\"><span class=\"outlookSwitch\"></span><span class=\"outlookIcon iconFileAdd\"></span>"+ObjectUtils.toString(auth.get(AuthDao.NAME))+"</div></td>").append("\n\t");
				html.append("        </tr>").append("\n\t");
				List<Map> childList = (List) auth.get(TreeUtils.CHILD);
				if (null!=childList&&!childList.isEmpty()) {
					html.append("<tr class=\"outlookBody\">").append("\n\t");	
					html.append("  <td><div class=\"outlookCont\">").append("\n\t");	
					html.append("    <ul class=\"infoList navList\">").append("\n\t");
					for(int  j=0;j<childList.size();j++){
						Map  childMap=childList.get(j);
						if(null!=childMap&&!childMap.isEmpty()){
							//	二级菜单   普通状态：infoItem    激活状态：infoItem_active
							/*if(i>8&&j>8){
								html.append("     <li class=\"infoItem\" id=\"infoItem_"+(i+1)+"_"+(j+1)+"\">").append("\n\t");	
							}else if(i>8&&j<9){
								html.append("     <li class=\"infoItem\" id=\"infoItem_"+(i+1)+"_0"+(j+1)+"\">").append("\n\t");	
							}else if(i<9&&j>8){
								html.append("     <li class=\"infoItem\" id=\"infoItem_0"+(i+1)+"_"+(j+1)+"\">").append("\n\t");	
							}else{
								html.append("     <li class=\"infoItem\" id=\"infoItem_0"+(i+1)+"_0"+(j+1)+"\">").append("\n\t");	
							}*/
							html.append("     <li class=\"infoItem\" id=\""+ObjectUtils.toString(childMap.get("AUTH_ID"))+"\">").append("\n\t");	
							
							List<Map> lastChildList = (List) childMap.get(TreeUtils.CHILD);
							if(null!=lastChildList&&!lastChildList.isEmpty()){
							
								html.append("      <div class=\"infoTitle\"><span class=\"navSwitch\"></span>"+ObjectUtils.toString(childMap.get("NAME")).trim()+"</div>").append("\n\t");
								html.append(" <ul class=\"thirdList\">").append("\n\t");
								for(int  k=0;k<lastChildList.size();k++){
									 Map  lastChildMap=lastChildList.get(k);
									 if(null!=lastChildMap&&!lastChildMap.isEmpty()){
									//三级菜单    普通状态：navItem    激活状态：navItem_active
										 html.append(" <li class=\"navItem\">").append("\n\t");
										  html.append(" <a target=\"mainFrame\" href=\""
													+ ctx+ ObjectUtils.toString(lastChildMap.get("PARAM")).trim()
													+"?formMap.HREPORT_ID="+hreport_id
													+ "\" >");
										 html.append(ObjectUtils.toString(
													lastChildMap.get("NAME")).trim());
										 html.append("</a>	"); 
										 html.append("</li>").append("\n\t"); 
									 }
									
								}
								html.append(" </ul>").append("\n\t");
							  }else{
								  String  type=ObjectUtils.toString(childMap.get("TYPE"));
								  
								  
								     html.append(" <div class=\"infoTitle\"><span class=\"navSwitch noSub\"></span>").append("\n\t");
								     if("1".equals(type)){
								    	 html.append("                    <a target=\"mainFrame\" href=\""
													+ ctx+ ObjectUtils.toString(childMap.get("PARAM")).trim()
													+"?formMap.HREPORT_ID="+hreport_id
													+ "\" >");	 
								     }else{
								    	 html.append("                    <a target=\"mainFrame\" href=\""
													+ ctx+ ObjectUtils.toString(childMap.get("PARAM")).trim()+ "\" >"); 
								     }
								    
									 html.append(ObjectUtils.toString(
											 childMap.get("NAME")).trim());
									 html.append("</a>	"); 
									 html.append("</div>").append("\n\t");
								 }
							html.append("   </li>");
							}
						}
					html.append("   </ul>");
					html.append("  </div></td>").append("\n\t");
					html.append("</tr>").append("\n\t");
				}
				html.append("     </table>\n\t");
				html.append("   </td>\n\t");
				html.append("</tr>\n\t");
			}
		}
		return html;
	}

	

}
