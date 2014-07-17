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
            out.println("<script>alert(\"注销成功，即将跳转到首页!\");</script>");
        }
      }

          
         if (name==null)
            {
           //如果没有session显示以下信息
      out.println("<h3 class=\"text-center\">您尚未登录！无法浏览以下内容!<a  href=\"http://websocketjava.sinaapp.com\">请登录</a></h3>");
}
         else{
            // 有session显示已登录用户信息
%>
<div class="container">
    <div class="row">  
      <div class="col-lg-2">
      </div>
        <div class="col-lg-9 col-xs-12">
    <div class="row">
      <br>
      <br>
        <div class="col-lg-10 col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-comment"></span>web chat 聊天室
                    <div class="btn-group pull-right">
                        <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </button>
                        <ul class="dropdown-menu slidedown">
                            <li><a href=""><span class="glyphicon glyphicon-refresh">
                            </span>刷新</a></li>
                            <li><a href=""><span class="glyphicon glyphicon-ok-sign">
                            </span>在线</a></li>
                            <li><a href=""><span class="glyphicon glyphicon-remove">
                            </span>忙碌</a></li>
                            <li><a href=""><span class="glyphicon glyphicon-time"></span>
                                离开</a></li>
                        </ul>
                    </div>
                </div>

     <!-- chat content -->
                <div class="panel-body" id="scroll">
                    <ul class="chat" >
                 <div id="console-container">
                  <div id="console">
              </div>
              </div>
                    </ul><!-- end of the ul -->
                </div><!-- end of the panel body -->
                <div class="panel-footer">          
                        <input  type="text" id="chat" class="form-control input-sm " placeholder="输入信息，按回车" />
                       <!--  <span class="input-group-btn">
                            <button class="btn btn-warning btn-sm" type="submit">
                                回车</button>
                        </span> -->
                 
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div><%
}
%>
  <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>
          <!-- JavaScript jQuery code from Bootply.com editor -->
<script src="dist/js/chatroom.js"></script>

</body>
</html>