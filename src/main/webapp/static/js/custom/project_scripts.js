$(function(){
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

		var project_name = $( "#dialog_project_name" ),
			allFields = $( [] ).add( project_name ),
			tips = $( ".validateTips" );

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

		$( "a.update_button" )
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
		$( "a.create_button" )
			.button()
			.click(function() {
				$( "#dialog-form" ).data("button_title", false).dialog( "open" );
			});
})

