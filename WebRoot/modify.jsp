<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
    
    <title>White Blog - 修改博文</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page"> 
	
	<link href="assets/css/bootstrap.min.css" rel="stylesheet">
	<!-- Font Awesome CSS -->
	<link href="assets/css/font-awesome.min.css" rel="stylesheet">
	<!-- Jasny CSS -->
	<link href="assets/css/jasny-bootstrap.min.css" rel="stylesheet">
	<!-- Animate CSS -->
	<link href="assets/css/animate.css" rel="stylesheet">
	<!-- Code CSS -->
	<link href="assets/css/tomorrow-night.css" rel="stylesheet" />
	<!-- Gallery CSS -->
	<link href="assets/css/bootstrap-gallery.css" rel="stylesheet">
	<!-- ColorBox CSS -->
	<link href="assets/css/colorbox.css" rel="stylesheet">
	<!-- Custom font -->
	<link href='assets/css/googleFont.css' rel='stylesheet' type='text/css'>
	<link href='assets/css/googleFont2.css' rel='stylesheet' type='text/css'>
	<!-- Custom styles for this template -->
	<link href="assets/css/style.css" rel="stylesheet">
	
	<link type="text/css" rel="stylesheet" href="MyEditor/xheditor_skin/default/ui.css" />
	<script type="text/javascript" src="MyEditor/JS/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="MyEditor/JS/xheditor-1.2.2.min.js"></script>		
	<script type="text/javascript" src="MyEditor/JS/zh-cn.js"></script>
				
	<style type="text/css">
		.btnCode {
		background:transparent url(assets/img/code.gif) no-repeat 16px 16px;
		background-position:2px 2px;
		}
	</style>
	<script type="text/javascript">		
		$(document).ready(function(){  
			var plugins={
				Code:{c:'btnCode',t:'插入代码',h:1,e:function(){
					var _this=this;
					var htmlCode='<div><select id="xheCodeType"><option value="html">HTML/XML</option><option value="js">Javascript</option><option value="css">CSS</option><option value="php">PHP</option><option value="java">Java</option><option value="py">Python</option><option value="pl">Perl</option><option value="rb">Ruby</option><option value="cs">C#</option><option value="c">C++/C</option><option value="vb">VB/ASP</option><option value="">其它</option></select></div><div><textarea id="xheCodeValue" wrap="soft" spellcheck="false" style="width:300px;height:100px;" /></div><div style="text-align:right;"><input type="button" id="xheSave" value="确定" /></div>';			
					var jCode=$(htmlCode),jType=$('#xheCodeType',jCode),jValue=$('#xheCodeValue',jCode),jSave=$('#xheSave',jCode);
					jSave.click(function(){
						_this.loadBookmark();						
						_this.pasteText('[code='+jType.val()+']\r\n'+jValue.val()+'\r\n[/code]');						
						_this.hidePanel();
						return false;	
					});
					_this.saveBookmark();
					_this.showDialog(jCode);
				}},		
			};
			$('#elm1').xheditor({
				plugins:plugins,
				tools:'full',				
				showBlocktag:false,
				forcePtag:false,
				shortcuts:{'ctrl+enter':submitForm},
				skin:'default',  
				html5Upload:false,
				upMultiple:'1',
                //upMultiple:false,  
                upImgUrl: "UploadFileServlet",  
                upImgExt: "jpg,jpeg,gif,bmp,png",  
                onUpload:insertUpload  
			});            
            //xbhEditor编辑器图片上传回调函数  
            function insertUpload(msg) {  
                var _msg = msg.toString();  
                var _picture_name = _msg.substring(_msg.lastIndexOf("/")+1);  
                var _picture_path = Substring(_msg);  
                var _str = "<input type='checkbox' name='_pictures' value='"+_picture_path+"' checked='checked' onclick='return false'/><label>"+_picture_name+"</label><br/>";  
                $("#elm1").append(_msg);  
                $("#uploadList").append(_str);  
            }  
            //处理服务器返回到回调函数的字符串内容,格式是JSON的数据格式.  
            function Substring(s){  
                return s.substring(s.substring(0,s.lastIndexOf("/")).lastIndexOf("/"),s.length);  
            }  
        });  
		function submitForm(){$('#frmDemo').submit();}
		//var document.getElementsByName("filedata");
	</script>	
  </head>
<body onload="timedCount()">
  <s:div class="canvas">
	<s:div cssClass="canvas-overlay"></s:div>
  		<header>
			<nav class="navbar navbar-fixed-top nav-down navbar-laread">
				<div class="container">
					<div class="navbar-header">
						<a class="navbar-brand" href="medium-image-v1-2.html"><img height="64" src="assets/img/logo-light.png" alt=""></a>
					</div>
								
					<c:choose>
						<c:when test="${sessionScope.loginUser == null}">
							<a href="#" data-toggle="modal" data-target="#login-form" class="modal-form">
								<i class="fa fa-user"></i>
							</a>									
						</c:when>
						<c:otherwise>
							<div class="get-post-titles" style="margin-left:20px">
								<button  type="button" class="close_qp navbar-toggle push-navbar-full" data-navbar-type="article">
									<i class="fa fa-bars"></i>
								</button>
							</div>		
							<div class="get-post-titles">					
								<button id="notice" type="button" class="navbar-toggle push-navbar" data-navbar-type="default">
									<i id="checkicon" class="fa fa-bell-o"></i>
								</button>						
							</div>
							<div class="get-post-titles" style="margin-right:10px">					
								<button type="button" class="navbar-toggle push-navbar-undo" data-navbar-type="default" onclick="location.href='showMailList.action'">
									<i class="fa fa-envelope"></i>
								</button>						
							</div>
							<a class="modal-form">${sessionScope.loginUser.username}</a>
						</c:otherwise>
					</c:choose>
					<button type="button" class="navbar-toggle collapsed menu-collapse" data-toggle="collapse" data-target="#main-nav">
						<span class="sr-only">Toggle navigation</span>
						<i class="fa fa-plus"></i>
					</button>
				</div>
			</nav>
		</header> 
		  
		<s:div cssClass="container">		
			<s:form action="modify" method="POST" id="frmDemo" enctype="multipart/form-data" theme="simple">	
				<s:div cssClass="head-text">				
					<h1>${sessionScope.loginUser.username}</h1>
					<s:hidden name="id" value="%{blogId}"></s:hidden>
				</s:div>			
	      	<s:div>		 	            		       	      
	           <p>文章标题</p>                     
	           <s:textfield  cssClass="form-control" name="currentBlog.title" size="8" value="%{blog.title}"/>	           
	        </s:div>   
	        <s:div>                          
	          	<p>文章内容</p>             	          	 
	          	<s:textarea id="elm1" name="currentBlog.content" class="xheditor" rows="12" cols="80" style="width: 100%" value="%{blog.content}"></s:textarea>	          	                     
	      	</s:div>	
	      	<s:div id="uploadList"></s:div>        		      	
	      	<s:div>
		       	<p>文章分类</p>
		       	<s:radio list="#{'0':'生活','1':'教育','2':'医疗/社会福利','3':'艺术/娱乐','4':'IT/互联网','5':'金融/投资','6':'交通/物流','7':'农林牧渔','8':'机械/电子','9':'综合'}" name="category" value="%{blogtype.supertypeId}"/>		 		           				       		      		  
	        </s:div>
	      	<s:div>
		       	<p>添加关键字</p>		     
		       	<s:textfield cssClass="form-control" name="blogtype.typename" size="8" value="%{blogtype.typename}" />				      
		       	<s:label>（基于文章分类的具体描述）</s:label>		                   
	        </s:div>        
			<s:div> 
			<s:div cssStyle="padding-top:1%;margin:0 auto;">
	        <s:submit value="发表" cssClass="btn btn-grey btn-outline btn-rounded"/>      
	        </s:div>
	        <s:property value="hint"></s:property>
	        </s:div>                   
	   </s:form>		
		</s:div>		
	</s:div> 	
	</div> 	   
	
  </body>
  <script type="text/javascript">		
		$("#notice").click(function(){
			$("#slideform").empty();
			$.ajax({
				url:"notice.action",
				type:"POST",
				dataType:"json",
				success:function(data){
				$.each(data,function(i,list){  
                       		var _tr = '<li class="pt-culture pt-art"><div><h5><i>' + list.noticeId + '</i><a>' + list.content + '</a>' +
						'</h5><div class="post-subinfo"></div></div></li>'
                       		 $("#slideform").append(_tr);
                    })
				}
			})	
		});
	</script>
	
	
	
	<script type="text/javascript">
		var t
		function timedCount()
		{
			$.ajax({
				url:"checkNotice.action",
				type:"POST",
				datatype:"json",
				success:function(data){
					if(data == "new"){
						$("#checkicon").attr("class","fa fa-bell fa-spin");
					}else{
						$("#checkicon").attr("class","fa fa-bell-o")
					}
				}
			})
			t=setTimeout("timedCount()",10000)
		}
	</script>

	<script type ="text/javascript">
	function delete_row(delete_id){
		if(confirm("确定要删除？")){
			$.ajax({
				url:"deleteBlog.action?id="+delete_id,
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data == -1){
						$("li").remove("#blog-"+delete_id);
						//$(delete_id).parent().parent().parent().remove();
						window.alert("删除成功");
					}else{
						window.alert("删除失败");
					}
				}
			})
			//$("li").remove("#"+delete_id);
		}
	}
	</script>
	<script type ="text/javascript">
		$(".Edit_qp").click(function(){
			$("#delete_vision").empty();
			$("#delete_vision").toggleClass("delete-blog");
			$("#delete_vision").toggleClass("view-blog");
			var classes = $("#delete_vision").attr("class");
			var actionStr = "#";
			var delete_icon = "";
			var onclick_str = "";
			if(classes.indexOf("view-blog") >= 0) {
				delete_icon = "delete_icon fa fa-file-text-o";
			}else{
				delete_icon = "delete_icon fa fa-times";
	// 			onclick_str = "onclick=\"delete_row(this)\"";
			}
			$.ajax({
				url:"changeDeleteList.action",
				type:"POST",
				dataType:"json",
				success:function(data){
				$.each(data, function(i, list){
					var color_str = ""
					if(classes.indexOf("view-blog") >= 0) {
						$(".Edit_qp").html("删除文章");
						actionStr = "content.action?id="+list.blogId;
						color_str="color:#ffffff";
					}else {
						$(".Edit_qp").html("返回");
						onclick_str="onclick=\"delete_row("+list.blogId+")\"";
						color_str="color:#FF4500";
					}
					var _tr = '<li class="pt-fashion pt-culture" id="blog-'+list.blogId+'"><div class="container"><h5><i class="'+delete_icon+'" style='+color_str+'></i>'+
					'<a class="delete_qp" href="'+actionStr+'"'+onclick_str+'>'+list.title+'</a></h5><div class="post-subinfo">'+
					'<span>'+list.time+'</span>   •   <span>2 Comments</span></div></div></li>';
					$("#delete_vision").append(_tr);				
				})
				}
			})
			var canvasHeight = $('.canvas').outerHeight();
			$('.navmenu-quan').height(canvasHeight);
			$('.post-title-list > li > div').toggleClass('container');
		})
	</script>
</html>