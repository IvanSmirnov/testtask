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
	<script src="./static/js/custom/project_scripts.js"></script>
	<link rel="stylesheet" href="./static/css/demos.css">
	
</head>
<body>
<table>
	<tr>
		<td><h4><a href="./listusers"><b>Список пользователей</b></a></h4></td>
		<td><h4><a href="./listprojects"><FONT style="BACKGROUND-COLOR: yellow"><b>Список проектов</b></FONT></a></h4></td>
		<td><h4><a href="./tasks"><b>Назначения</b></a></h4></td>
		<td><h4><a href="./userpage"><b>Мои проекты</b></a></h4></td>
	</tr>
</table>
<div id="dialog-form" title="Проект">
	<p class="validateTips"></p>
	<form>
	<fieldset>
		<label for="dialog_project_name">Название проекта:</label>
		<input type="text" name="dialog_project_name" id="dialog_project_name" class="text ui-widget-content ui-corner-all" />
	</fieldset>
	</form>
</div>

<a href="#" class="create_button"></a>
<h3>Проекты</h3>
<c:if  test="${!empty projectList}">
<table class="table_data" id="projecttable">
<tr>
	<th>id</th>
	<th>Название проекта</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
<c:forEach items="${projectList}" var="project">
	<tr>
		<td>${project.id}</td>
		<td>${project.title}</td>
		<td>
			<a href="#" class="update_button" data-id="${project.id}"></a>
		</td>
		<td><a href="deleteproject/${project.id}" class="delete_button"></a></td>
	</tr>
</c:forEach>
</table>
</c:if>

</body>
</html>
