<%@page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="./static/themes/base/jquery.ui.all.css">
	<script src="./static/js/jquery-1.8.2.js"></script>
	<script src="./static/js/ui/jquery.ui.core.js"></script>
	<script src="./static/js/ui/jquery.ui.widget.js"></script>
	<script src="./static/js/ui/jquery.ui.mouse.js"></script>
	<script src="./static/js/ui/jquery.ui.button.js"></script>
	<link rel="stylesheet" href="./static/css/demos.css">
	<style type="text/css">
		.table_data, .table_data td {
			border-collapse: collapse;
			border: 1px solid #aaa;
			margin: 2px;
			padding: 10px;
		}
		.table_data th {
			font-weight: bold;
			background-color: #5C82FF;
			color: white;
		}
		.delete_button {
	   		display:block;
			margin: 2px;
	   		background: url('./static/img/remove.png');
	   		width:24px;
	   		height:24px;
		}
		body { font-size: 80%; }
		label, input { display:block; }
		input.text { margin-bottom:12px; width:95%; padding: .4em; }
		fieldset { padding:0; border:0; margin-top:25px; }
		h1 { font-size: 2em; margin: .8em 0; }
		div#users-contain { width: 350px; margin: 20px 0; }
		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
	</style>
		<script>
	$(function() { $("#search_button").click(function( event ) {
			var selected_usr_id = $("#user_selector").val();
			if( selected_usr_id != null )
			$("#projects_table").html("<img src='./static/img/loading.gif'></img>").load("./listtasksbyuser/"+selected_usr_id, {limit: 25}, 
			    function (responseText, textStatus, req) {
				if (textStatus == "error") {
				  return "Ajax error.";
				} else {
			}});
		});
	});
		</script>
</head>
<body>
<table>
	<tr>
		<td><h4><a href="./listusers"><b>Список пользователей</b></a></h4></td>
		<td><h4><a href="./listprojects"><b>Список проектов</b></a></h4></td>
		<td><h4><a href="./tasks"><b>Назначения</b></a></h4></td>
		<td><h4><a href="./userpage"><FONT style="BACKGROUND-COLOR: yellow"><b>Мои проекты</b></FONT></a></h4></td>
	</tr>
</table>

<h3>Текущие проекты</h3>
<table>
	<td>Выберите своё имя из списка и нажмите на Поиск: </td>
<tr>
	<td>
		<select id="user_selector">
		<c:if  test="${!empty userList}">
		<c:forEach items="${userList}" var="user">
		   <option value=${user.id}>(${user.id}) ${user.first_name} ${user.second_name}</option>
		</c:forEach>
		</c:if>
		</select>
	</td>
	<td><button id="search_button">Поиск</button></td>
</tr>
</table>
<div id="projects_table">
<div>

</body>
</html>
