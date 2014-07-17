<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String from_user=request.getParameter("to_user");
    String to_user=(String)session.getAttribute("username");
    String send_time=(String)session.getAttribute("send_time");
    //out.print(send_time);
     //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k"); 
 //将isread置为1
     String sql1= "UPDATE content SET isread=1 WHERE to_user='"+to_user+"' and from_user='"+from_user+"' ORDER BY time DESC LIMIT 1";
     PreparedStatement ps= conn.prepareStatement(sql1);
     ps.executeUpdate();
     ps.close();
%>