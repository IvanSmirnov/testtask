$(function() {
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
	function updateTips( t ) {
		tips.text( t ).addClass( "ui-state-highlight" );
		setTimeout(function() {
			tips.removeClass( "ui-state-highlight", 1500 );
		}, 500 );
	}
	var first_name = $( "#dialog_first_name" ),
		second_name = $( "#dialog_second_name" ),
		login = $( "#dialog_login" ),
		password = $( "#dialog_password" ),
		allFields = $( [] ).add( login ).add( password ).add( first_name ).add( second_name ),
		tips = $( ".validateTips" );



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
									var td_val = $(this).find("td");
									td_val.eq(1).html( first_name.val() );
									td_val.eq(2).html( second_name.val() );
									td_val.eq(3).html( login.val() );
									td_val.eq(4).html( password.val() );
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

	$( "a.update_button" )
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
	$( "a.create_button" )
		.button()
		.click(function() {
			$( "#dialog-form" ).data("button_title", false).dialog( "open" );
		});
})
