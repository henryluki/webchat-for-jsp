<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    //String text=request.getParameter("searchtext");
    //编码转换
     String text=request.getParameter("searchtext");
   //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k");  
    //以下查询语句注意  username='"+name+"'" + 连接符 连接双引号（“）
    String sql= "SELECT * FROM user WHERE username LIKE '%" + text + "%' ORDER BY username ASC";
    PreparedStatement os= conn.prepareStatement(sql);
    ResultSet rs = os.executeQuery();
     //先判断是否存在该用户名
     if(!rs.next())
     {
%> 
<!-- 显示没有该联系人 -->
<h4 class="text-danger "> &nbsp;&nbsp; 没有所搜联系人...</h4>
<%   
}else{
    rs.previous(); 
%>
<!-- 显示相关联系人 -->
<div class="col-lg-4 col-xs-4" >
    <div class="row">
        <div class="col-lg-10 col-xs-12">
            <div class="panel panel-danger">
            	 <div class="panel-heading">
            	 	<span class="glyphicon glyphicon-user"></span>所搜相关联系人。。。
            	 </div>
               <!-- chat content -->
                <div>
                	 <ul class="chat" >
<% 
    while (rs.next()) 
    {              
                   out.print("<li><form name=\"form\" action=\"addfriends.jsp\" method=\"post\"><div class=\"input-group\">");
                    out.print("<span class=\"input-group-btn\">");
                      out.print("<h4>"+rs.getString("username")+"</h4>");
                       out.print("<input type=\"hidden\" name=\"user2\" value=\""+rs.getString("username")+"\"/>");
                       out.print("<button class=\"btn btn-warning btn-sm pull-right\" id=\"btn-chat\" type=\"submit\"> 加为好友</button>");
                         out.print("</span>");
                         out.print("</div>");
                         out.print("</form></li>");
}   
%> 


                 
                </ul>
              </div>
        </div>
    </div>
</div>
</div>
<%
 rs.close();
 conn.close();//关闭数据库
}
%>