<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
     request.setCharacterEncoding("UTF-8");
     String user2=request.getParameter("user2");
     // 获取session里的信息
     String user1=(String)session.getAttribute("username");
     //不能添加自己为好友
     if(user1.equals(user2))
     {
      //返回ss
     response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com/chat.jsp");  
     out.println("<script>alert(\"不能添加自己！\");</script>");
 }
      else{
   //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k"); 
    String sql1= "SELECT friend FROM relationship WHERE user1='"+user1+"' AND user2='"+user2+"'";
    PreparedStatement os= conn.prepareStatement(sql1);
    ResultSet rs = os.executeQuery();

     //先确认该用户是否已经被添加
     //如果没被添加则将数据存入数据库
     if(!rs.next())
     {
    //将数据写进数据库
   String sql2="INSERT INTO relationship(user1,user2,friend) VALUES(?,?,0)" ;
   PreparedStatement ps= conn.prepareStatement(sql2);
   ps.setString(1,user1); 
   ps.setString(2,user2);
   ps.executeUpdate();
   ps.close();
    //写入成功 
    response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com/chat.jsp");  
     out.println("<script>alert(\"好友请求已发出，等待对方添加!\");</script>");
   }

   else{ 
   //查询有结果
   out.println("<script>alert(\"该用户已经是您的好友！\");</script>");
   response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com/chat.jsp");  
 }
   os.close();
   conn.close();//关闭数据库    

}
%>
