$(document).on('turbolinks:load', function() {
	$('#search-date').datepicker({
	    format: "yyyy-mm-dd",
	    autoclose: true,
	    todayHighlight: true
	});
})