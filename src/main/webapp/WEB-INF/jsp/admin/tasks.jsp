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
	<script src="./static/js/custom/tasks_scripts.js"></script>
	<link rel="stylesheet" href="./static/css/demos.css">
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
