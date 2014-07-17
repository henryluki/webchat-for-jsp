function showdiv(targetid,i){       
         var target=document.getElementById(targetid);
          document.getElementById('msg').innerHTML="";
         var n=i;
            if (target.style.display=="block"){
                target.style.display="none";
             
            } else {
            	  document.getElementById('user').innerHTML= "与  "+document.getElementById('username'+n).innerHTML+"    聊天中...";
                document.getElementById('to_user').value=document.getElementById('username'+n).innerHTML;
                document.getElementById('resultDiv').style.display="none";
                target.style.display="block";
            }
        }
//ajax 
 var xmlHttp;
        window.onload=function(){
            if(window.XMLHttpRequest){//IE7+, Firefox, Chrome, Opera, Safari
                xmlHttp = new XMLHttpRequest();
                
            }
            else if(window.ActiveXObject){
                try{
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch(e){
                    try{//IE5 and IE6
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                        xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    }
                    catch(e){
                        window.alert("该浏览器不支持Ajax");
                    }
                }
            }
            else{
                window.alert("该浏览器不支持Ajax.");
            }
             //触发好友添加确认
            friendadd();
        }
        function search(){
            var searchtext= document.searchform.searchtext.value;
            if(searchtext=="")
                {
                    window.alert("请输入您查找的联系人");
                }
            else{
                  var url = "searchforuser.jsp?searchtext="+searchtext;
                  xmlHttp.open("POST", url, true);  
                  document.getElementById('resultDiv').style.display="block";              
                  xmlHttp.onreadystatechange= function() {
                     if (xmlHttp.readyState==4) {
                        resultDiv.innerHTML = xmlHttp.responseText;
                    }
                              
              }   
               xmlHttp.send();    
            }
          
        }
        function sendmsg(){
            var content= document.sendmsgform.content.value;
            var to_user= document.sendmsgform.to_user.value;
            if(content=="")
                {
                    window.alert("内容不能为空");
                }
            else{
                  var url = "sendmessage.jsp?content="+content+"&to_user="+to_user;
                  xmlHttp.open("POST", url, true);                
                  xmlHttp.onreadystatechange=function() {
                     if (xmlHttp.readyState==4) {
                        document.getElementById('msg').innerHTML += xmlHttp.responseText;
                        document.getElementById('chat').value="";
                    }          
              }   
               xmlHttp.send();  
               //滚动条置底
            scrolltob();
             if(document.getElementById('msg').innerHTML += xmlHttp.responseText){
              setTimeout(receivemsg,500);
            }
          } 
        }
       function receivemsg(){
            var to_user= document.getElementById('to_user').value;
            var url = "receivemessage.jsp?to_user="+to_user;
            xmlHttp.open("POST", url, true);        
            xmlHttp.onreadystatechange=function() {
              if (xmlHttp.readyState==4) {
                 document.getElementById('msg').innerHTML += xmlHttp.responseText;
                 xmlHttp.onreadystatechange = null;
              }                
            } 
            xmlHttp.send();
            //滚动条置底
            scrolltob();
            if(document.getElementById('msg').innerHTML += xmlHttp.responseText){
              setTimeout(stopmsg,500);
            }
        }
       function stopmsg(){
            var to_user= document.getElementById('to_user').value;
            var url = "stopmessage.jsp?to_user="+to_user;
            xmlHttp.open("POST", url, true);           
            xmlHttp.send(); 
        }
         window.setInterval(receivemsg,3000);
         //window.setInterval(stopmsg,1500); 
        // window.setInterval(scrolltob,1000); 

        function friendadd(){
          //来自某人的请求
           var url = "addfriends_sure.jsp";
           xmlHttp.open("POST", url, true);   
           document.getElementById('resultDiv').style.display="block"; 
                  xmlHttp.onreadystatechange= function() {
                     if (xmlHttp.readyState==4) {
                        resultDiv.innerHTML = xmlHttp.responseText;
                    }
                  }
                  
            xmlHttp.send();
          }

        function scrolltob()
        {
           document.getElementById('scroll').scrollTop=document.getElementById('scroll').scrollHeight;  
        }

        //check_hostory的异步
        function checkhistory(){
             document.getElementById('msg').innerHTML="";
            var to_user= document.getElementById('to_user').value;
            var url = "checkhistory.jsp?to_user="+to_user;
            xmlHttp.open("POST", url, true);        
            xmlHttp.onreadystatechange=function() {
              if (xmlHttp.readyState==4) {
                 document.getElementById('msg').innerHTML += xmlHttp.responseText;
              }                
            } 
            xmlHttp.send();
        }
        //addfriends_sure的异步
        function opyes(){
           document.getElementById('op').value="yes";
           var add_user1= document.getElementById('add_user1').value;
           var op=document.getElementById('op').value;
            var url = "addfriends_sure.jsp?op="+op+"&user1="+add_user1;
            xmlHttp.open("POST", url, true);  
            xmlHttp.onreadystatechange= function() {
                     if (xmlHttp.readyState==4) {
                        alert("添加成功！");
                        window.location.href="http://websocketjava.sinaapp.com/chat.jsp"
                    }
                  }         
            xmlHttp.send(); 
        }
        function opno(){
           document.getElementById('op').value="no";
           var add_user1= document.getElementById('add_user1').value;
           var op=document.getElementById('op').value;
            var url = "addfriends_sure.jsp?op="+op+"&user1="+add_user1;
            xmlHttp.open("POST", url, true);  
            xmlHttp.onreadystatechange= function() {
                     if (xmlHttp.readyState==4) {
                      window.location.href="http://websocketjava.sinaapp.com/chat.jsp"
                    }
                  }        
            xmlHttp.send(); 
        }