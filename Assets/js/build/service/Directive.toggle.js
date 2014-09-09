myApp.directive('ngToggle', [
		function(){
			return {
				priority: 100,
				restrict: 'A',
				link: function(scope, element, attrs) {
					element.bind('click', function() {
						if($("html#toggle").length === 0) {
							$("html").attr("id", "toggle");
						} else {
							$("html#toggle").removeAttr("id");
						}
					});
				}
			};
		}
	]);
