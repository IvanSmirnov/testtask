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
	.update-project {
   		display:block;
   		background: url('./static/img/edit.png');
   		width:24px;
   		height:24px;
	}
	.create-project {
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
		var project_name = $( "#dialog_project_name" ),
			allFields = $( [] ).add( project_name ),
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
			height: 250,
			width: 350,
			modal: true,
			buttons: {
				"Сохранить": function() {
					var bValid = true;
					allFields.removeClass( "ui-state-error" );
					bValid = bValid && checkLength( project_name, "названии проекта", 3, 80 );
					bValid = bValid && checkRegexp( project_name,  /^([0-9a-zа-я_ \f\n\r\t\v])+$/i, "Имя проекта может состоять из букв, цифр, пробелов и знаков подчёркивания" );
					if ( bValid ) {
						var project_id = $(this).data("id");
						var isUpdate = $(this).data("button_title");
						var url_str = isUpdate ? "./updateproject" : "./addproject";
							$.ajax({
								url: url_str,
								type: "POST",
								 data: {
								    id: project_id,
								    title: project_name.val()
								 },
							  success: function(response) {
								var updated_id = response;
								if( isUpdate ){
									$("#projecttable tr").each(function() {
									    var user_id = $(this).find("td").eq(0).html();
									    if( updated_id == user_id ){
										$(this).find("td").eq(1).empty().append( project_name.val() );
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
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});

		$( "a.update-project" )
			.button()
			.click(function() {
				var id = $(this).data("id");
				$('#projecttable tr').each(function() {
				    var project_id = $(this).find("td").eq(0).html();
				    if( id == project_id ){
					project_name.val( $(this).find("td").eq(1).html() );
					return false;
				    }
				});

				$( "#dialog-form" ).data("button_title", true).data("id", id).dialog( "open" );
			});
		$( "a.create-project" )
			.button()
			.click(function() {
				$( "#dialog-form" ).data("button_title", false).dialog( "open" );
			});
	});
	</script>
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

<a href="#" class="create-project"></a>
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
			<a href="#" class="update-project" data-id="${project.id}"></a>
		</td>
		<td><a href="deleteproject/${project.id}" class="delete_button"></a></td>
	</tr>
</c:forEach>
</table>
</c:if>

</body>
</html>