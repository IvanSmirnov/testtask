<%@page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<style type="text/css">
		body {
			font-family: sans-serif;
		}
		.data, .data td {
			border-collapse: collapse;
			margin: 10px;
			padding: 2px;
		}
		.data th {
			font-weight: bold;
			background-color: #5C82FF;
			color: white;
			width: 300px;
		}	
		.delete_button {
	   		display:block;
			margin: 2px;
	   		background: url('./static/img/remove.png');
	   		width:24px;
	   		height:24px;
		}
	</style>

</head>
<body>

<table class="data">
<tr>
	<td>Пользователь : </td>
	<td>
		<select id="user_selector">
		<c:if  test="${!empty userList}">
		<c:forEach items="${userList}" var="user">
		   <option value=${user.id}>(${user.id}) ${user.first_name} ${user.second_name}</option>
		</c:forEach>
		</c:if>
		</select>
	</td>
	<td>Начало: <input type="text" id="datepicker_begin" readonly="true" name="fromDate"/></td>
	<td>Конец: <input type="text" id="datepicker_finish" readonly="true" name="toDate"/></td>
	<td><button id="assign_button">Назначить</button></td>
</tr>
<tr>
	<th>user id</th>
	<th>Пользователь</th>
	<th>Дата начала</th>
	<th>Дата конца</th>
	<th>&nbsp;</th>
</tr>
<c:if  test="${!empty taskList}">
<c:forEach items="${taskList}" var="task">
	<tr>
		<td>${task.user.id}</td>
		<td>${task.user.first_name} ${task.user.second_name}</td>
		<td>${task.date_begin}</td>
		<td>${task.date_finish}</td>
		<td><a href="#" class="delete_button" data-removeid="${task.id}"></a></td>
	</tr>
</c:forEach>
</c:if>
</table>


</body>
</html>
