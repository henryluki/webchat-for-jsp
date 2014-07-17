<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>WebChat--we chat</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link href="dist/css/bootstrap.min.css" rel="stylesheet">
		<link href="dist/css/font-awesome.min.css" rel="stylesheet">
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
       <script type='text/javascript' src="js/respond.min.js"></script>
		<![endif]-->
		<link href="dist/css/styles.css" rel="stylesheet">
<script type="text/javascript">
    function clearvalue(){
      document.getElementById("name").value="";
      document.getElementById("pass").value="";
      document.getElementById("pass_s").value="";
    }
    function check(){
    if(document.getElementById("order").checked)
    {
      document.getElementById("order").value="setcookie";
    }
  }
    </script>
	</head>
	<body>
<div class="container-full">
<img src="dist/home.jpg"></img>
      <div class="row">
       
        <div class="col-lg-12 text-center v-center">
          
          <h1 class="hidden-xs">Web Chat</h1>
          <h2 class="text-info">“we chat， we share， we happy。”</h2>
          <p class="lead ">这是一款基于WebSocket技术实现的聊天室和AJAX实现的点对点通信聊天webapp</p>
          
          <br class="hidden-xs"><br class="hidden-xs"><br class="hidden-xs">
          <div class="row">
            <div class="col-lg-4">
              </div>
               <div class="col-lg-2 col-xs-5">
              <button class="btn btn-block btn-lg btn-primary" data-toggle="modal" data-target="#signModal"type="button">登录</button>
              </div>
                <div class="col-lg-2 col-xs-5">
             <button class=" btn btn-block btn-lg btn-primary col-lg-2" data-toggle="modal" data-target="#registerModal" type="button">注册</button>
           </div>
        </div>
        </div>
      </div> <!-- /row -->
<!--login Modal -->
<div class="modal fade" id="signModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header modal-style-l">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title text-center" id="signModalLabel">登录</h4>
      </div>
      <div class="modal-body ">
        <form class="form-horizontal" role="form" action="login.jsp" method="post">
            <div class="form-group">
              <label class="col-sm-4 control-label">用户名:</label>
              <div class="col-sm-5">
                <input name="username" type="text" class="form-control"  placeholder="用户名"autofocus required>
              </div>
            </div>
            <div class="form-group">
              <label  class="col-sm-4 control-label">密码:</label>
              <div class="col-sm-5">
                <input type="password" class="form-control"  name="password"  placeholder="密码" required></input>
                <div class="checkbox">
                  <label>
                    <input id="order" type="checkbox" name="checkbox" onclick="check()">记住用户名
                  </label>
                </div>
              </div>
            </div>
             <div class="form-group">
              <div class="col-sm-4">
              </div>
               <div class="col-sm-5">
             <button type="submit" class="btn btn-success btn-block pull-right">登录</button>
           </div>
           </div>
          </form> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!--register Modal -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header modal-style-l">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title text-center" id="registerModalLabel">注册</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form" action="register.jsp" method="post">
            <div class="form-group">
              <label class="col-sm-4 control-label">用户名:</label>
              <div class="col-sm-5">
                <input name="username1" type="text" class="form-control" id="name" placeholder="用户名"autofocus required>
              </div>
            </div>
            <div class="form-group">
              <label  class="col-sm-4 control-label">设置密码:</label>
              <div class="col-sm-5">
                <input type="password" class="form-control"  name="password1" id="pass" placeholder="密码" required></input>
              </div>
            </div>
       <div class="form-group">
              <label  class="col-sm-4 control-label">确认密码:</label>
              <div class="col-sm-5">
                <input type="password" class="form-control"  name="password_sure" id="pass_s"placeholder="密码确认" ></input>
              </div>
            </div>
      <div class="form-group">
              <div class="col-sm-4">
              </div>
               <div class="col-sm-5">
            <button type="button"class="btn btn-default" onclick="clearvalue()">重置</button>
             <button type="submit" class="btn btn-success pull-right">注册</button>
           </div>
            </div>
          </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</div> <!-- /container full -->

        <div class="col-lg-12">
          <p class="pull-right"><a href="http://nickwebsite.sinaapp.com">nick'website</a> &nbsp; ©Copyright 2014 Nick</p>
        </div>
    </div>
</div>


	<!-- script references -->
    <script src="dist/js/jquery-2.0.2.min.js"></script>
		<script src="dist/js/bootstrap.min.js"></script>
		<script src="dist/js/scripts.js"></script>
	</body>
</html>