<%@ page language="java" contentType="application/vnd.ms-excel; charset= UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*"%>
<% String co= (String)request.getAttribute("VContent");String filename= com.ssi.framework.utils.POIUtils.getXlsFileName((String)request.getAttribute("filename"));
response.addHeader("Content-Disposition", "attachment;filename="+filename);
 
%><html><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><body><%
out.print(co);
%></body></html>
