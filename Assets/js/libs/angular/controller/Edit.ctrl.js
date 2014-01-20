function EditCtrl($scope, $routeParams, $location, list) {
	$scope.user_id = $sid;

	$scope.routeParams = $routeParams;
	console.log("Edit", $scope.routeParams.id);

	var promise_types = list.getAsync('GET', '/edit_army/'+$scope.routeParams.id+'.json', {});

	promise_types.then(function( data ){
		$scope.name = list.data.ArmyList.name;
		$scope.descr = list.data.ArmyList.descr;
		$scope.points_limit = parseInt(list.data.ArmyList.point_limit);
		$scope.hide = list.data.ArmyList.hide;
	});

	$scope.submit_edit = function() {
		if ($scope.edit_army_list.$invalid) {
			$scope.formMessage = "Form contains errors";
		} else {
			$scope.formMessage = "";
//+'/'+$scope.routeParams.hash
			var promise_post = list.getAsync('POST', '/edit/save/'+$scope.routeParams.id+'.json', {'name':this.name, 'descr':this.descr, 'point_limit':this.points_limit, 'hide':this.hide});

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
}