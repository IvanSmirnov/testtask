<%@page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<table  class="table_data">
<tr>
	<th>project id</th>
	<th>Проект</th>
	<th>Дата начала</th>
	<th>Дата конца</th>
</tr>
	<c:if  test="${!empty taskList}">
	<c:forEach items="${taskList}" var="task">
		<tr>
			<td>${task.project.id}</td>
			<td>${task.project.title}</td>
			<td>${task.date_begin}</td>
			<td>${task.date_finish}</td>
		</tr>
	</c:forEach>
	</c:if>
</table>


