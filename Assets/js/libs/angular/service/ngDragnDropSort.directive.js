angular.module('ngDragnDrop', []).
	directive('ngDrag', [
		function(){
			return {
				restrict: 'A',
				link: function(scope, element, attrs){
					element.draggable({
						cursor: "move",
						connectToSortable: attrs.ngAccept,
						helper: "clone",
						revert: "invalid",
						stop: function( event, ui) {
							scope.getSquad();
						}
					});
				}
			};
		}
	]).
	directive('ngDrop', [
		function(){
			return {
				restrict: 'A',
				link: function(scope, element, attrs){
					element.sortable({
						revert: true,
						placeholder: "a-drop-highlight",
						start: function(event, ui) {
							//console.log("start", ui.item.index(), ui.item.attr("id"));

							scope.startPos = ui.item.index();
							scope.knownId = ui.item.attr("id");
						},
						update: function(event, ui) {
							scope.dropPos = ui.item.index();
							if(ui.item.attr("id") != undefined) {
								//console.log("moved", ui.item.index(), ui.item.attr("id"));
								scope.squadPositionsOnSort();
							}
						},
						stop: function(event, ui) {
							//check it wasn't here previously
							if(!ui.item.data('tag') && !ui.item.data('handle') && ui.item.attr("id") == undefined) {
								ui.item.data('tag', true); //tag new draggable drops
								scope.squadBuilder("troops", ui.item);
							}
						}
					}).disableSelection();
				}
			};
		}
	]);