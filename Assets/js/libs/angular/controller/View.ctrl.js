function ViewCtrl($scope, $routeParams, $location, list) {
	$scope.user_id = $sid;

	$scope.routeParams = $routeParams;
	console.log("View", $scope.routeParams.id);

	var promise_my = list.getAsync('GET', '/view_army/'+$scope.routeParams.id+'.json', {});
	$scope.army = {};

	promise_my.then(function( data ){
		$scope.army = list.data.ArmyLists;
	});


	$scope.dateMomment = function(value) {
		return moment(value, 'YYYY-MM-DD HH:mm:ss').fromNow();
	};
}