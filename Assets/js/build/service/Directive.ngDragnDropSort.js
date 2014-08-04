myApp.directive('ngDrag', [
		function(){
			return {
				restrict: 'A',
				link: function($scope, element, attrs){
					attrs.$observe('ngAccept', function(ngAccept) {
						element.draggable({
							cursor: "move",
							connectToSortable: ngAccept,
							helper: "clone",
							revert: "invalid",
							stop: function( event, ui) {
								$scope.getSquad();
							}
						});
					});


				}
			};
		}
	])
	.directive('ngDrop', [
		function(){
			return {
				restrict: 'A',
				link: function($scope, element, attrs){
					var drop = -1;
					element.sortable({
						revert: true,
						placeholder: "a-drop-highlight",
						start: function(event, ui) {
							//console.log("start", ui.item.index(), ui.item.attr("id"));

							$scope.startPos = ui.item.index();
							$scope.knownId = ui.item.attr("id");
						},
						update: function(event, ui) {
							$scope.dropPos = ui.item.index();
							drop = ui.item.index();
							if(ui.item.attr("id") !== undefined) {
								//console.log("moved", ui.item.index(), ui.item.attr("id"), ui.item);
								$scope.squadPositionsOnSort(ui.item.attr("id"), ui.item.index(), $scope.startPos);
							}
						},
						stop: function(event, ui) {
							//check it wasn't here previously
							if(!ui.item.data('tag') && !ui.item.data('handle') && ui.item.attr("id") === undefined) {
								ui.item.data('tag', true); //tag new draggable drops

								var classes = ui.item.attr("class").split(" ");

								$scope.squadBuilder(classes[1], ui.item, drop);
							}
						}
					}).disableSelection();
				}
			};
		}
	]);