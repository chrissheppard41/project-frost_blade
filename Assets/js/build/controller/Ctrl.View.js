myApp.controller('ViewCtrl', ["$scope", "$routeParams", "$location", "list", "vote", "squadbuilder", function($scope, $routeParams, $location, list, vote, squadbuilder) {
	$scope.user_id = $sid;

	$scope.routeParams = $routeParams;
	console.log("View", $scope.routeParams.id);

	var promise_unit_types = list.getAsync('GET', '/types.json', {});
	$scope.unit_types = {};

	promise_unit_types.then(function( data ){
		$scope.unit_types = list.data.types;
	});

	var promise_my = list.getAsync('GET', '/view_army/'+$scope.routeParams.id+'.json', {});
	$scope.army = {};

	promise_my.then(function( data ){
		$scope.army = list.data.armylists;

		var promise_squads = list.getSecure('GET', '/squads_units/'+$scope.army.armies_id+'', {});
		$scope.squads = {};

		promise_squads.then(function( data ){
			$scope.squads = data.squads;
			$scope.currentSquad();
		});
	});

	$scope.armycost = 0;

	$scope.currentSquad = function() {
		squadbuilder.generate($scope);
	};

	$scope.votes = function(id, type) {
		vote.votingView($scope, id, type);
		$(".active.up").removeClass("active");
		$(".active.down").removeClass("active");
	};

	$scope.dateMomment = function(value) {
		return moment(value, 'YYYY-MM-DD HH:mm:ss').fromNow();
	};
}]);