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
	.update-user {
   		display:block;
   		background: url('./static/img/edit.png');
   		width:24px;
   		height:24px;
	}
	.create-user {
   		display:block;
   		background: url('./static/img/add.png');
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
		.ui-dialog .ui-state-error { padding: .3em; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
	</style>
	<script>
	$(function() {
		var first_name = $( "#dialog_first_name" ),
			second_name = $( "#dialog_second_name" ),
			login = $( "#dialog_login" ),
			password = $( "#dialog_password" ),
			allFields = $( [] ).add( login ).add( password ).add( first_name ).add( second_name ),
			tips = $( ".validateTips" );

		function updateTips( t ) {
			tips.text( t ).addClass( "ui-state-highlight" );
			setTimeout(function() {
				tips.removeClass( "ui-state-highlight", 1500 );
			}, 500 );
		}

		function checkLength( o, n, min, max ) {
			if ( o.val().length > max || o.val().length < min ) {
				o.addClass( "ui-state-error" );
				updateTips( "Количество символов в " + n + " должно быть от " +
					min + " до " + max + "." );
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp( o, regexp, n ) {
			if ( !( regexp.test( o.val() ) ) ) {
				o.addClass( "ui-state-error" );
				updateTips( n );
				return false;
			} else {
				return true;
			}
		}

		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 350,
			width: 350,
			modal: true,
			buttons: {
				"Сохранить": function() {
					var bValid = true;
					allFields.removeClass( "ui-state-error" );

					bValid = bValid && checkLength( login, "логине", 4, 16 );
					bValid = bValid && checkLength( password, "пароле", 4, 16 );
					bValid = bValid && checkLength( first_name, "имени", 3, 80 );
					bValid = bValid && checkLength( second_name, "фамилии", 3, 80 );
					bValid = bValid && checkRegexp( login, /^([0-9a-zа-я_ \f\n\r\t\v])+$/i, "Логин может состоять из букв, цифр, пробелов и знаков подчёркивания" );
					bValid = bValid && checkRegexp( password, /^([0-9a-zа-я_ \f\n\r\t\v])+$/i, "Пароль может состоять из букв, цифр, пробелов и знаков подчёркивания" );
					bValid = bValid && checkRegexp( first_name, /^([0-9a-zа-я_ \f\n\r\t\v])+$/i, "Имя может состоять из букв, цифр, пробелов и знаков подчёркивания" );
					bValid = bValid && checkRegexp( second_name, /^([0-9a-zа-я_ \f\n\r\t\v])+$/i, "Фамилия может состоять из букв, цифр, пробелов и знаков подчёркивания" );
					if ( bValid ) {
						var user_id = $(this).data("id");
						var isUpdate = $(this).data("button_title");
						var url_str = isUpdate ? "./updateuser" : "./adduser";
							$.ajax({
								url: url_str,
								type: "POST",
								 data: {
								    id: user_id,
								    login: login.val(),
								    password: password.val(),
								    first_name: first_name.val(),
								    second_name: second_name.val(),
								 },
							  success: function(response) {
								var updated_id = response;
								if( isUpdate ){
									$("#usertable tr").each(function() {
									    var user_id = $(this).find("td").eq(0).html();
									    if( updated_id == user_id ){
										$(this).find("td").eq(1).empty().append( first_name.val() );
										$(this).find("td").eq(2).empty().append( second_name.val() );
										$(this).find("td").eq(3).empty().append( login.val() );
										$(this).find("td").eq(4).empty().append( password.val() );
										return false;
									    }
									});
								} else {
									location.reload();
								}
								$( "#dialog-form" ).dialog( "close" );
							},
							  error: function(e){
							  	alert('Error: ' + e);
							  },
							dataType: "text"
						    });
						
					}
				},
				"Отмена": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});

		$( "a.update-user" )
			.button()
			.click(function() {
				var id = $(this).data("id");

				$('#usertable tr').each(function() {
				    var user_id = $(this).find("td").eq(0).html();
				    if( id == user_id ){
					first_name.val( $(this).find("td").eq(1).html() );
					second_name.val( $(this).find("td").eq(2).html() );
					login.val( $(this).find("td").eq(3).html() );
					password.val( $(this).find("td").eq(4).html() );
					return false;
				    }
				});

				$( "#dialog-form" ).data("button_title", true).data("id", id).dialog( "open" );
			});
		$( "a.create-user" )
			.button()
			.click(function() {
				$( "#dialog-form" ).data("button_title", false).dialog( "open" );
			});
	});
	</script>
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

<a href="#" class="create-user"></a>
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
		<td><a href="#" class="update-user" data-id="${user.id}"></a></td>
		<td><a href="deleteuser/${user.id}" class="delete_button"></a></td>
	</tr>
</c:forEach>
</table>
</c:if>

</body>
</html>
