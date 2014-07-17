<%@ page language="java" import="java.util.*,java.sql.*,util.HTMLFilter,util.MD5" pageEncoding="UTF-8"%>

<%  
    request.setCharacterEncoding("UTF-8");
    String username=request.getParameter("username1");
    String password=request.getParameter("password1");
	  String password_sure=request.getParameter("password_sure"); 
    if(username!=null&&password!=null)
      {
    if(username.equals("")||password.equals("")||password_sure.equals(""))
     {  
      response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");  
      out.println("<script>alert(\"用户名或密码未填写！\");</script>");	 
    }
    else if(!password.equals(password_sure))
    {
     response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");  
    out.println("<script>alert(\"两次密码不正确！\");</script>");
  }
  else{
            
     //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k");  
     String sql1= "SELECT md5_password FROM user WHERE username='"+username+"'";
    PreparedStatement os= conn.prepareStatement(sql1);
    ResultSet rs = os.executeQuery();

     //先判断是否该用户已注册
     //如果没被注册则将数据存入数据库
     if(!rs.next())
     {
     //获取当地时间存到数据库
     java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
     java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
     String login_time = formatter.format(currentTime); //将日期时间格式化
       //简单过滤密码
        password=MD5.md5(password);
        
     //MD5加密
       String md5_password=HTMLFilter.filter(password);
    //将数据写进数据库
   String sql2="INSERT INTO user(username,md5_password,login_time) VALUES(?,?,?)" ;
   PreparedStatement ps= conn.prepareStatement(sql2);
   ps.setString(1,username); 
   ps.setString(2,md5_password);
   ps.setString(3,login_time);
   ps.executeUpdate();
   ps.close();
    //写入成功 重定向到登录页面
    response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");  
     out.println("<script>alert(\"注册成功，即将跳转到登陆界面!\");</script>");
   }

   else{ 
   //查询有结果 提示该用户已被注册   
    response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");  
   out.println("<script>alert(\"对不起，该用户名已被注册！\");</script>");
 }
   os.close();
   conn.close();//关闭数据库    

 }
}
%>
