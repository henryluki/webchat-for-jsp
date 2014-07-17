<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*,util.HTMLFilter" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    String to_user=request.getParameter("to_user");
    String from_user=(String)session.getAttribute("username");
    String i_content=request.getParameter("content");
    //过滤
    String content=HTMLFilter.filter(i_content);
     //获取发送时间
     java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
     java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
     String time = formatter.format(currentTime); //将日期时间格式化 
     if(session.getAttribute("time")==null)
     {
         session.setAttribute("send_time",time);
        
    }else{
        session.setAttribute("send_time",time);
    }
             
  //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k"); 
    String sql1="INSERT INTO content(content,from_user,to_user,time,isread) VALUES(?,?,?,?,0)" ;
    PreparedStatement ps= conn.prepareStatement(sql1);
    ps.setString(1,content); 
    ps.setString(2,from_user);
    ps.setString(3,to_user);
    ps.setString(4,time);
    int i=ps.executeUpdate();
    if(i==1)
    {
%>
<li class="right clearfix">
                      <div class="chat-body clearfix">
                           <div class="header">
                                <small class=" text-muted"><span class="glyphicon glyphicon-time"></span><%out.print(time);%></small>
                                 <strong class="pull-right primary-font"><%out.print(from_user);%></strong>
                                </div>  
                                <p><%out.print(content);%>
                                </p>
                            </div>
                        </li> <!-- one end -->
<%
}
    ps.close();
    conn.close();//关闭数据库   
%>