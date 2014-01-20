$(document).ready(function() {

	/* Caches selectors and gets the table prepared for sortable behaviour. */
	var $table = $('table.table-listings').attr('id', 'sortable');
	var $instructions = $('<p><em>Drag and drop rows to reorder.</em></p>');
	$table.before($instructions).after($instructions.clone());

	/**
	 *	Binds sortable behaviour to the table, where on update it makes an
	 *	AJAX request to the backend, alerting it of the change in sequence.
	 */
	$table.find('tbody').sortable({
		'axis': 'y',
		'cursor': 'move',
		'forceHelperSize': true,
		'forcePlaceholderSize': true,
		'handle': 'td',
		'helper': function(e, ui) {
			ui.children().each(function() {
				$(this).width($(this).width());
			});
			return ui;
		},
		'items': 'tr',
		'opacity': 1,
		'revert': true,
		'stop': function(event, ui) {
			var tableRow = ui.item;
			tableRow.children().each(function() {
				$(this).removeAttr('style');
			});
		},
		'update': function(event, ui) {
			var tableRow = ui.item;
			var sortUrl = $('#sortable').data('sortUrl') + '/' + $(tableRow).data('id') + '.json';
			var newOrder = $('tbody', '#sortable').sortable('toArray');
			var newPosition = $.inArray(tableRow.attr('id'), newOrder);

			$.ajax({
				data: { 'data[order]': newPosition },
				dataType: 'json',
				success: function(data) {
					if (data.success != 1) {
						alert('Error: ' + data.message);
					}
				},
				type: 'post',
				url: sortUrl
			});
		}
	});




















});