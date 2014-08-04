myApp.directive('ngLoadscreen', [
		function(){
			return {
				priority: 100,
				restrict: 'A',
				link: function(scope, element, attrs){
					Loader.init(element);
					scope.$watch(function() {return element.attr('class'); }, function(newValue){
						if(newValue !== undefined && newValue === "boom") {
							$(element).parent().parent().delay( 500 ).fadeOut("slow", function(){
								this.remove();
							});
						}
					});
				}
			};
		}
	]);
