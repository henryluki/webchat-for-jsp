<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*,util.HTMLFilter" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    String from_user=request.getParameter("to_user");
    String receive_user=(String)session.getAttribute("username");
             
    //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k"); 
    //以下查询语句注意  username='"+name+"'" + 连接符 连接双引号（“）
    String sql= "SELECT content,time FROM content WHERE to_user='"+receive_user+"' and from_user='"+from_user+"' and isread=0 ORDER BY time DESC LIMIT 1";
    PreparedStatement os= conn.prepareStatement(sql);
    ResultSet rs = os.executeQuery();
    while (rs.next())     
    { 
%>
    <li class="left clearfix">
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <strong class="primary-font"><%out.print(from_user);%></strong> <small class="pull-right text-muted">
                                        <span class="glyphicon glyphicon-time"></span><%=rs.getString("time")%></small>
                                </div>
                                <p>
                                   <%=rs.getString("content")%>
                                </p>
                            </div>
                        </li> <!-- one end -->
<%
    }
   
     os.close();
    conn.close();//关闭数据库   
%>
