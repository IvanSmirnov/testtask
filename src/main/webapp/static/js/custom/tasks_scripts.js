$(function() {
	function reloadDialogUI( _project_id ){

	    var loadUrl = "./listtasksbyproject/" + _project_id;  
		$("#dialog").html("<img src='./static/img/loading.gif'></img>").load(loadUrl, {limit: 25}, 
		    function (responseText, textStatus, req) {
			if (textStatus == "error") {
			  return "Ajax error.";
			} else { 

		$(":input[name='fromDate'], :input[name='toDate']")
			.val($.datepicker.formatDate('dd/mm/yy', new Date()))
			.datepicker($.extend({}, {
				beforeShow: function (input) { 
					return {
						minDate: (input.name == "toDate" 
							? $(":input[name='fromDate']").datepicker("getDate")
							: $.datepicker.parseDate("dd/mm/yy", "01/01/2009") ), 
						maxDate: (input.name == "fromDate" 
							? $(":input[name='toDate']").datepicker("getDate") 
							: $.datepicker.parseDate("dd/mm/yy", "01/01/2024"))
					}; 
				}, 
				dateFormat: "dd/mm/yy", 
				buttonImage: "./static/img/calendar.gif",
				showOn: "both",
				buttonImageOnly: true 
			})
		);
		$("a.delete_button").click(function( event ) {
			var removeid = $(this).data("removeid");
						$.ajax({
							url: "./removetask/"+removeid,
							type: "GET",
						  success: function(response) {
							reloadDialogUI( _project_id );
						},
						  error: function(e){
						  	alert('Error: ' + e);
						  },
						dataType: "text"
					    });
		});

		$("#assign_button").click(function( event ) {
				var selected_usr_id = $("#user_selector").val();
				if( selected_usr_id != null ){ 
						$.ajax({
							url: "./addtask",
							type: "POST",
							 data: {
							    user_id: selected_usr_id,
							    project_id: _project_id,
							    date_begin: $( "#datepicker_begin" ).datepicker('getDate'),
							    date_finish: $( "#datepicker_finish" ).datepicker('getDate')
							 },
						  success: function(response) {
							reloadDialogUI( _project_id );
						},
						  error: function(e){
						  	alert('Error: ' + e);
						  },
						dataType: "text"
					    });
				}
			});
			}}
		);  


	}

$( "#dialog" ).dialog({
		autoOpen: false,
		height: 300,
		width: 900,
		modal: true,
    open: function(event, ui) {
		$("span.ui-dialog-title").text($(this).data("project_title")); 
		reloadDialogUI( $(this).data("project_id") );
   	 },
		buttons: {
			Close: function() {
				$( this ).dialog( "close" );
			}
		}
	});

	$( "a.users" )
		.button()
		.click(function() {
			var project_id = $(this).data("id");
			var project_title = $(this).data("project_title");

			$( "#dialog" ).data("project_id", project_id).data("project_title", project_title).dialog( "open" );
		});
})
