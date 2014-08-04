myApp.directive('ngConfirmClick', [
		function(){
			return {
				priority: 100,
				restrict: 'A',
				link: function(scope, element, attrs){
					element.bind('click', function(e){
						var message = attrs.ngConfirmClick;
						var clickAction = attrs.confirmedClick;

						if(message && confirm(message)){
							e.stopImmediatePropagation();
							e.preventDefault();

							scope.$parent.submit_delete(clickAction);
						}
					});
				}
			};
		}
	]);
