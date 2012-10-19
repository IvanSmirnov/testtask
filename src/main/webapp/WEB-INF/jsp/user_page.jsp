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
