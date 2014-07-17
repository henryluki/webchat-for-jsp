<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
     request.setCharacterEncoding("UTF-8");
     // 获取session里的信息
     String user1=(String)session.getAttribute("username");
   //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k");  
    String sql1= "SELECT user1 FROM relationship WHERE user2='"+user1+"'AND friend=0 ";
    PreparedStatement os= conn.prepareStatement(sql1);
    ResultSet rs = os.executeQuery();
     //先确认该用户是否已经被添加
     //如果没被添加则将数据存入数据库
%>
   <!-- 显示相关联系人 -->
<div class="col-lg-8 col-xs-8" >
    <div class="row">
        <div class="col-lg-10 col-xs-12">
         <ul class="chat" >
<% 
    while (rs.next()) 
    {              
                      out.print("<div class=\"well text-primary\">");
                      out.print("<li>");
                      out.print("<h4>您有一条好友请求:  <strong class=\"text-danger\">"+rs.getString("user1")+"</strong>想要添加您为好友，是否同意？</h4>");
                       out.print("<input type=\"hidden\" name=\"add_user1\" id=\"add_user1\"value=\""+rs.getString("user1")+"\"/>");
                       out.print("<input type=\"hidden\" name=\"op\" id=\"op\" />");
                       out.print("<button class=\"col-lg-3 pull-left btn-success\" onclick=\"opyes()\">同意</button>");
                        out.print("<button class=\"col-lg-3 pull-right btn-danger\" onclick=\"opno()\">忽略</button>");
                          out.print("</li>");
                            out.print("</form></div>");
}   
%>
                 
                </ul>
              </div>
        </div>
</div> 
<%
    
   os.close();
     // 下面这一行用来获取提交信息
         String op = request.getParameter("op");
         if(op != null)
      {
        if( op.equals("yes") )
        {
           // 将好友关系置为1 并新增一条消息
             String user2=new String(request.getParameter("user1").getBytes("ISO8859_1"),"utf-8");
             String sql2="INSERT INTO relationship(user1,user2,friend) VALUES(?,?,1)" ;
             PreparedStatement ps= conn.prepareStatement(sql2);
             ps.setString(1,user1); 
             ps.setString(2,user2);
             ps.executeUpdate();
             ps.close();
             String sql3="UPDATE relationship SET friend=1 WHERE user1='"+user2+"' AND user2='"+user1+"'" ;
             PreparedStatement ns= conn.prepareStatement(sql3);
             ns.executeUpdate();
             ns.close();
        }
         if( op.equals("no") )
        {
           // 移除添加好友信息
            String user2=new String(request.getParameter("user1").getBytes("ISO8859_1"),"utf-8");
             String sql4="DELETE FROM relationship WHERE user1='"+user2+"' AND user2='"+user1+"'" ;
             PreparedStatement ns= conn.prepareStatement(sql4);
             ns.executeUpdate();
             ns.close();
        }
      }
   conn.close();//关闭数据库    

%>