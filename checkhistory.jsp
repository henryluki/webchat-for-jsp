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
    String sql= "SELECT from_user,content,time FROM content WHERE isread=1 and (to_user='"+receive_user+"' OR to_user='"+from_user+"') and ( from_user='"+receive_user+"' OR from_user='"+from_user+"') ORDER BY time DESC LIMIT 10";
    PreparedStatement os= conn.prepareStatement(sql);
    ResultSet rs = os.executeQuery();
    int i=0;
    if(rs.next())
        {
    out.print("<h4 class=\"text-info text-center\">以下是最近的聊天记录(最多10条)</h4>");
   }
   rs.previous();
    while (rs.next())     
    { 
     int num=i%2;
     if(num==0)
     {
      out.print("<li class=\"right clearfix\">");
                            out.print("<div class=\"chat-body clearfix\">");
                                out.print("<div class=\"header\">");
                                 out.print("<small class=\"text-muted\"><span class=\"glyphicon glyphicon-time\"></span>"+rs.getString("time")+"</small>");
                                  out.print("<strong class=\"pull-right primary-font\">"+rs.getString("from_user")+"</strong>");
                               out.print("</div><p class=\"pull-right\">"+rs.getString("content")+"</p>");
                            out.print("</div></li> <!-- one end -->");
}
    
    else{
    out.print("<li class=\"left clearfix\">");
                            out.print("<div class=\"chat-body clearfix\">");
                                out.print("<div class=\"header\">");
                                    out.print("<strong class=\"primary-font\">"+rs.getString("from_user")+"</strong> <small class=\"pull-right text-muted\">");
                                        out.print("<span class=\"glyphicon glyphicon-time\"></span>"+rs.getString("time")+"</small>");
                                out.print("</div><p>"+rs.getString("content")+"</p>");
                            out.print("</div></li> <!-- one end -->");
}  
i++;
}
   
     os.close();
    conn.close();//关闭数据库   
%>
