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
	<script src="./static/js/custom/users_scripts.js"></script>
	<link rel="stylesheet" href="./static/css/demos.css">
</head>
<body>

<div id="dialog-form" title="Пользователь">
	<p class="validateTips">Все поля должны быть заполнены.</p>

	<form>
	<fieldset>
		<label for="dialog_login">Логин</label>
		<input type="text" name="dialog_login" id="dialog_login" class="text ui-widget-content ui-corner-all" />
		<label for="dialog_password">Пароль</label>
		<input type="dialog_password" name="dialog_password" id="dialog_password" value="" class="text ui-widget-content ui-corner-all" />
		<label for="dialog_first_name">Имя</label>
		<input type="dialog_first_name" name="dialog_first_name" id="dialog_first_name" value="" class="text ui-widget-content ui-corner-all" />
		<label for="dialog_first_name">Фамилия</label>
		<input type="dialog_second_name" name="dialog_second_name" id="dialog_second_name" value="" class="text ui-widget-content ui-corner-all" />
	</fieldset>
	</form>
</div>

<table>
	<tr>
		<td><h4><a href="./listusers"><FONT style="BACKGROUND-COLOR: yellow"><b>Список пользователей</b></FONT></a></h4></td>
		<td><h4><a href="./listprojects"><b>Список проектов</b></a></h4></td>
		<td><h4><a href="./tasks"><b>Назначения</b></a></h4></td>
		<td><h4><a href="./userpage"><b>Мои проекты</b></a></h4></td>
	</tr>
</table>

<a href="#" class="create_button"></a>
<h3>Пользователи</h3>
<c:if  test="${!empty userList}">
<table class="table_data" id="usertable">
<tr>
	<th>id</th>
	<th>Имя</th>
	<th>Фамилия</th>
	<th>Логин</th>
	<th>Пароль</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
<c:forEach items="${userList}" var="user">
	<tr>
		<td>${user.id}</td>
		<td>${user.first_name}</td>
		<td>${user.second_name}</td>
		<td>${user.login}</td>
		<td>${user.password}</td>
		<td><a href="#" class="update_button" data-id="${user.id}"></a></td>
		<td><a href="deleteuser/${user.id}" class="delete_button"></a></td>
	</tr>
</c:forEach>
</table>
</c:if>

</body>
</html>
