myApp.directive('ngLoadscreen', [
		function(){
			return {
				priority: 100,
				restrict: 'A',
				link: function(scope, element, attrs){
					Loader.init(element);
				}
			};
		}
	]);
