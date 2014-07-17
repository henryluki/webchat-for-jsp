<%@ page language="java" import="java.util.*,java.sql.*,util.HTMLFilter,util.MD5" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>    
        <meta http-equiv="content-type" content="text/html;charset=UTF-8"> 
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>WebChat--we chat</title> 
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
       <!-- 最新 Bootstrap 核心 CSS 文件 -->
       <link rel="stylesheet" href="dist/css/bootstrap.min.css">
       <link rel="stylesheet" href="dist/css/chat.css">        
        <!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
          <script type='text/javascript' src="dist/js/respond.min.js"></script>
        <![endif]--> 
           <link href="dist/css/font-awesome.min.css" rel="stylesheet">
       </head>
    <body>
<% 
 // 检查cookie
   Cookie[]cookies =request.getCookies();
   if(cookies!=null)
    { 
      //获取登录时间
     java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
     java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
     String current_time = formatter.format(currentTime);//将日期时间格式化  
    // 有cookie的情况下自动登录
    for(int i=0;i<cookies.length;i++)
    {
    if(cookies[i].getName().equals("username"))
    {
    String cookie_username=cookies[i].getValue();
    session.setAttribute("username",cookie_username);
    session.setAttribute("time",current_time);
    break;
  }
}
}
     // 获取session里的信息
         String name=(String)session.getAttribute("username");
         String current_time=(String)session.getAttribute("time");

    // 下面这一行用来获取注销信息
         String op = request.getParameter("op");
         if(op != null)
      {
        if( op.equals("del") )
        {
           // 移除session内所有内容
            session.invalidate();
            response.setHeader("refresh", "0.1; URL =http://websocketjava.sinaapp.com");  
           // out.println("<script>alert(\"注销成功，即将跳转到首页!\");</script>");
        }

      }

          
         if (name==null)
            {
           //如果没有session显示以下信息
      out.println("<h3 class=\"text-center\">您尚未登录！无法浏览以下内容!</h3><h3 class=\"text-center\"><a  href=\"http://websocketjava.sinaapp.com\">请登录</a></h3>");
}
         else{
            // 有session显示已登录用户信息
%>
<h1 class="hidden-xs ">Web Chat<small>--“we chat， we share， we happy。”</small></h1>
<div class="container">
    <div class="row hidden-xs">
        <div class="col-lg-3 ">
         <form class="navbar-form " role="search" name="searchform">
            <div class="input-group ">
              <input type="text" class="form-control" placeholder="搜素联系人" name="searchtext"></input>      
         <div class="input-group-btn">
        <button class="btn btn-success" type="button" onclick="search()"><i class="glyphicon glyphicon-search"></i></button>
      </div>
    </div> 
    </form>
    </div>
        <div class="col-lg-7">
            <div class="pull-right">
                <a href="./chat.jsp?op=del" class="btn btn-danger" role="button"><span class="glyphicon glyphicon-off"></span>退出</a>
            </div>
        </div>
  <!--         <div class="pull-right col-lg-3">
  <a href="chatroom.jsp" class="btn btn-info"><span class="glyphicon glyphicon-hand-right"></span>聊天室入口</a>
  </div> -->
    </div>
    <div class="row">   
    <div class="col-lg-3 col-xs-3 ">
      <div class="panel panel-primary">
        <div class="panel-heading">
           <span class="glyphicon glyphicon-user"></span>联系人
        </div>
         <div class="panel-body">
     <!-- chat list -->

<%   
  //连接数据库
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn=DriverManager.getConnection( "jdbc:mysql://w.rdc.sae.sina.com.cn:3307/app_websocketjava?useUnicode=true&characterEncoding=utf-8","kxy4yj2xk2","iwj0kw45h4l302km0kh03zyyhy2ij52ik5k5i55k"); 
    String sql2= "SELECT user.username FROM user JOIN relationship ON user.username=relationship.user2 and relationship.user1='"+name+"' and relationship.friend=1";
    PreparedStatement ps= conn.prepareStatement(sql2);
    ResultSet rs2 = ps.executeQuery(); 
      if(!rs2.next())
     {
     out.println("<h4 class=\"text-info \">您还没有好友，请添加好友!</h4>");
   }
    else{  

    //存在记录 rs就要向上移一条记录 因为rs.next会滚动一条记录了 
      rs2.previous(); 
      int i=0;
       while (rs2.next())     
    { 
    out.println("<div class=\"media conversation\" >");
     out.println("<div class=\"media-body\">");
                  out.print("<h4 class=\"media-heading text-danger\" id=\"username"+i+"\">"+rs2.getString("username")+"</h4>");
           out.println("<small class=\"text-info\">我是我，不用迎合别人</small>");       
           out.println("<button class=\"btn btn-success btn-sm pull-right\"onClick=\"showdiv('block',"+i+")\">聊天</button>");   
             out.println("</div>");    
        out.println("</div>");
     i++;
    }
    ps.close();
    conn.close();//关闭数据库
  }
%>

        </div><!-- end of chat list -->
     </div>
    </div>
    <div id="resultDiv"></div>
        <div class="col-lg-9 col-xs-9 none" id="block">
    <div class="row">
        <div class="col-lg-10 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-comment" id="user" name="user"></span>
                    <div class="btn-group pull-right">
                       <button  class="text-info " onClick="checkhistory()"><span class="glyphicon glyphicon-eye-open">
                            </span>查看历史记录</button>
                    </div>
                </div>

     <!-- chat content -->
                <div class="panel-body" id="scroll">
                    <ul class="chat" id="msg">
                    </ul><!-- end of the ul -->
                </div><!-- end of the panel body -->
                <div class="panel-footer">
                <form name="sendmsgform">
                   <div class="input-group">        
                        <input name="content" type="text" id="chat" class="form-control input-sm " placeholder="输入信息，点击发送" required></input>
                        <input type="hidden" name="to_user" id ="to_user"/>
                        <span class="input-group-btn">
                            <button class="btn btn-warning " type="button" onclick="sendmsg()">
                                发送</button>
                        </span>
                  </div>
                </form>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>



<%
} //else
%>
  <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>
          <!-- JavaScript jQuery code from Bootply.com editor -->
 <script src="dist/js/chat.js"></script>
</body>
</html>