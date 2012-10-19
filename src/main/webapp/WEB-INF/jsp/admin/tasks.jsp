<%@page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<link rel="stylesheet" href="./static/themes/base/jquery.ui.all.css">
	<script src="./static/js/jquery-1.8.2.js"></script>
	<script src="./static/js/external/jquery.bgiframe-2.1.2.js"></script>
	<script src="./static/js/ui/jquery.ui.core.js"></script>
	<script src="./static/js/ui/jquery.ui.widget.js"></script>
	<script src="./static/js/ui/jquery.ui.mouse.js"></script>
	<script src="./static/js/ui/jquery.ui.button.js"></script>
	<script src="./static/js/ui/jquery.ui.draggable.js"></script>
	<script src="./static/js/ui/jquery.ui.position.js"></script>
	<script src="./static/js/ui/jquery.ui.resizable.js"></script>
	<script src="./static/js/ui/jquery.ui.dialog.js"></script>
	<script src="./static/js/ui/jquery-ui.js"></script>

	<link rel="stylesheet" href="./static/css/demos.css">
	<style type="text/css">
		.table_data, .table_data td {
			border-collapse: collapse;
			border: 1px solid #aaa;
			margin: 2px;
			padding: 2px;
		}
		.table_data th {
			font-weight: bold;
			background-color: #5C82FF;
			color: white;
		}
	.delete_button {
   		display:block;
   		background: url('./static/img/remove.png');
   		width:24px;
   		height:24px;
	}
	.update-project {
   		display:block;
   		background: url('./static/img/edit.png');
   		width:24px;
   		height:24px;
	}
	.users {
   		display:block;
   		background: url('./static/img/users.png');
   		width:36px;
   		height:36px;
	}
		body { font-size: 80%; }
		label, input { display:block; }
		input.text { margin-bottom:12px; width:95%; padding: .4em; }
		fieldset { padding:0; border:0; margin-top:25px; }
		h1 { font-size: 2em; margin: .8em 0; }
		div#users-contain { width: 350px; margin: 20px 0; }
		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
		.ui-dialog .ui-state-error { padding: .3em; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
	</style>
	<script>
	$(function() {
		function reloadDialogUI( _project_id ){
		    $.ajaxSetup ({  
			cache: false  
		    });  

		    var loadUrl = "./listtasksbyproject/" + _project_id;  
			$("#dialog").html("<img src='./static/img/loading.gif'></img>").load(loadUrl, {limit: 25}, 
			    function (responseText, textStatus, req) {
				if (textStatus == "error") {
				  return "Ajax error.";
				} else { 

			$(":input[name='fromDate'], :input[name='toDate']")
				.val($.datepicker.formatDate('dd/mm/yy', new Date()))
				.datepicker($.extend({}, {
					beforeShow: function (input) { 
						return {
							minDate: (input.name == "toDate" 
								? $(":input[name='fromDate']").datepicker("getDate")
								: $.datepicker.parseDate("dd/mm/yy", "01/01/2009") ), 
							maxDate: (input.name == "fromDate" 
								? $(":input[name='toDate']").datepicker("getDate") 
								: $.datepicker.parseDate("dd/mm/yy", "01/01/2024"))
						}; 
					}, 
					dateFormat: "dd/mm/yy", 
					buttonImage: "./static/img/calendar.gif",
					showOn: "both",
					buttonImageOnly: true 
				})
			);
			$("a.delete_button").click(function( event ) {
				var removeid = $(this).data("removeid");
							$.ajax({
								url: "./removetask/"+removeid,
								type: "GET",
							  success: function(response) {
								reloadDialogUI( _project_id );
							},
							  error: function(e){
							  	alert('Error: ' + e);
							  },
							dataType: "text"
						    });
			});

			$("#assign_button").click(function( event ) {
					var selected_usr_id = $("#user_selector").val();
					if( selected_usr_id != null ){ 
							$.ajax({
								url: "./addtask",
								type: "POST",
								 data: {
								    user_id: selected_usr_id,
								    project_id: _project_id,
								    date_begin: $( "#datepicker_begin" ).datepicker('getDate'),
								    date_finish: $( "#datepicker_finish" ).datepicker('getDate')
								 },
							  success: function(response) {
								reloadDialogUI( _project_id );
							},
							  error: function(e){
							  	alert('Error: ' + e);
							  },
							dataType: "text"
						    });
					}
				});
				}}
			);  


		}

	$( "#dialog" ).dialog({
			autoOpen: false,
			height: 300,
			width: 900,
			modal: true,
	    open: function(event, ui) {
			$("span.ui-dialog-title").text($(this).data("project_title")); 
			reloadDialogUI( $(this).data("project_id") );
	   	 },
			buttons: {
				Close: function() {
					$( this ).dialog( "close" );
				}
			}
		});

		$( "a.users" )
			.button()
			.click(function() {
				var project_id = $(this).data("id");
				var project_title = $(this).data("project_title");

				$( "#dialog" ).data("project_id", project_id).data("project_title", project_title).dialog( "open" );
			});
	});

	</script>
</head>
<body>
<table>
	<tr>
		<td><h4><a href="./listusers"><b>Список пользователей</b></a></h4></td>
		<td><h4><a href="./listprojects"><b>Список проектов</b></a></h4></td>
		<td><h4><a href="./tasks"><FONT style="BACKGROUND-COLOR: yellow"><b>Назначения</b></FONT></a></h4></td>
		<td><h4><a href="./userpage"><b>Мои проекты</b></a></h4></td>
	</tr>
</table>
<div id="dialog">
<a href="#" class="add-user"></a>
</div>

<h3>Назначения</h3>
<c:if  test="${!empty projectList}">
<table class="table_data" id="projecttable">
<tr>
	<th>id</th>
	<th>Проект</th>
	<th>&nbsp;</th>
</tr>
<c:forEach items="${projectList}" var="project">
	<tr>
		<td>${project.id}</td>
		<td>${project.title}</td>
		<td>
			<a href="#" class="users" data-id="${project.id}" data-project_title="${project.title}"></a>
		</td>
	</tr>
</c:forEach>
</table>
</c:if>

</body>
</html>
