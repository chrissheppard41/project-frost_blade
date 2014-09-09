myApp.directive('ngClickAdd', [
		function(){
			return {
				restrict: 'A',
				link: function($scope, element, attrs){
					//add click
					element.bind('click', function(e) {
						e.stopImmediatePropagation();
						e.preventDefault();

						$scope.getSquad();
						var classes = $(this).attr("class");
						$scope.squadBuilder(classes, $(this), -1);

					});
				}
			};
		}
	]);