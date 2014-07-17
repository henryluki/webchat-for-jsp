<%@ page language="java" import="java.util.*,java.sql.*,util.HTMLFilter,util.MD5" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    //登陆验证
    String name=request.getParameter("username");
    String password=request.getParameter("password");

    if(name!=null&&password!=null)
      {
    if(name.equals("")||password.equals(""))
    {  
    //out.println("<script>alert(\"用户名或密码未填写！\");</script>");
    response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");  	 
  }
  else{
   //过滤加密
        password=MD5.md5(password);
       String def_password=HTMLFilter.filter(password);

             
    //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k"); 
    //以下查询语句注意  username='"+name+"'" + 连接符 连接双引号（“）
    String sql= "SELECT md5_password FROM user WHERE username='"+name+"'";
    PreparedStatement os= conn.prepareStatement(sql);
    ResultSet rs = os.executeQuery();
     String md5_password=null;
     //先判断是否存在该用户名
     if(!rs.next())
     {
     out.println("<script>alert(\"该用户名没有注册！\");</script>");
     response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");       
   }
   else{
    //存在记录 rs就要向上移一条记录 因为rs.next会滚动一条记录了 
      rs.previous(); 
    //从数据库调出密码 并进行验证
    while (rs.next())     
    { 
        md5_password=rs.getString("md5_password");  
        } 
      if(!def_password.equals(md5_password)) 
      {
            out.println("<script>alert(\"密码错误！\");</script>");
            response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");    
          }
      else{
      //cookie动作
     //将cookie写到客户端
     String message=request.getParameter("checkbox");
     if(message!=null)
     {
     if(message.equals("setcookie"))
     {
     //将信息存入cookie
     Cookie cookie_name=new Cookie("username",name);
     //设置时间限制 一天
     cookie_name.setMaxAge(86400);
     //将cookie存到客户端
     response.addCookie(cookie_name);
     out.println("<script>alert(\"cookie已存入，有效期为一天！\");</script>");
     }
    }
     //session动作
     //获取登录时间
     java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
     java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
     String current_time = formatter.format(currentTime); //将日期时间格式化 
     //将用户名和登录时间写进session
     session.setAttribute("username",name);
	   session.setAttribute("time",current_time);
     response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com/chat.jsp");  
     //out.println("<script>alert(\"登陆成功!\");</script>");
	}
    
os.close();
conn.close();//关闭数据库
}
}
}
%>