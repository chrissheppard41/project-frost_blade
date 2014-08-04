myApp.controller('EditCtrl', ["$scope", "$routeParams", "$location", "list", function($scope, $routeParams, $location, list) {
	$scope.user_id = $sid;

	$scope.routeParams = $routeParams;
	console.log("Edit", $scope.routeParams.id);

	var promise_types = list.getAsync('GET', '/view_army/'+$scope.routeParams.id+'.json', {});

	promise_types.then(function( data ){
		$scope.name = list.data.ArmyLists.name;
		$scope.descr = list.data.ArmyLists.descr;
		$scope.points_limit = parseInt(list.data.ArmyLists.point_limit, 0);
		$scope.hide = list.data.ArmyLists.hide;
	});

	$scope.submit_edit = function() {
		if ($scope.edit_army_list.$invalid) {
			$scope.formMessage = "Form contains errors";
		} else {
			$scope.formMessage = "";

			var promise_post = list.getAsync('POST', '/edit/save/'+$scope.routeParams.id+'.json', {name:this.name, descr:this.descr, point_limit:this.points_limit, hide:this.hide});

			promise_post.then(function( data ){
				if(list.data.code == 200) {

					$location.path('#/');
				} else {
					$scope.displayFormmessages(list);
				}
			});
		}
		return false;
	};
}]);