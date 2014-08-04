myApp.controller('SetupCtrl', ["$scope", "$routeParams", "$location", "list", "squadbuilder", function($scope, $routeParams, $location, list, squadbuilder) {
	$scope.user_id = $sid;
	$scope.squad_list = [];

	$scope.routeParams = $routeParams;
	$scope.armycost = 0;

	var promise_unit_types = list.getAsync('GET', '/types.json', {});
	$scope.unit_types = {};

	promise_unit_types.then(function( data ){
		$scope.unit_types = list.data.Types;
	});

	var promise_my = list.getAsync('GET', '/view_army/'+$scope.routeParams.id+'.json', {});
	$scope.army = {};

	promise_my.then(function( data ){
		$scope.army = list.data.ArmyLists;

		var promise_squads = list.getSecure('GET', '/squads_units/'+$scope.army.armies_id+'', {});
		$scope.squads = {};

		promise_squads.then(function( data ){
			$scope.squads = data.Squads;
			$scope.currentSquad();
		});

	});

	$scope.currentDraggedSquad = null;
	$scope.getSquad = function() {
		$scope.currentDraggedSquad = this.squad;
	};
	$scope.dropPos = 0;
	$scope.startPos = 0;
	$scope.knownId = null;

	$scope.currentSquad = function() {
		squadbuilder.generate($scope);
	};

	$scope.squadBuilder = function(group, element, drop) {
		squadbuilder.build($scope, group, element, drop);
	};

	$scope.submit_army = function() {
		var promise_my = list.getAsync('POST', '/save_units/'+$scope.routeParams.id+'.json', SquadList.submitSquad());
		promise_my.then(function( data ){
			if(data.code == 200) {
				$location.path('view/'+$scope.routeParams.id);
			}
		});

		return false;
	};

	$scope.squadPositionsOnSort = function(knownId, dropPos, startPos) {
		SquadList.squadPositionsOnSort(knownId, dropPos, startPos);
	};

	$scope.removeSquad = function(squadId, squadPos) {
		SquadList.removeSquad(squadId, squadPos);
		$scope.armycost = SquadList.getTotal();
	};

	$scope.addSquad = function(squad, unit) {
		UnitCount.add(squad, unit);
		$scope.armycost = SquadList.getTotal();
	};
	$scope.subSquad = function(squad, unit) {
		UnitCount.sub(squad, unit);
		$scope.armycost = SquadList.getTotal();
	};

	$scope.addWargear = function(squad, unit) {
		Wargear.add(squad, unit, this.selectedItem);
		$scope.armycost = SquadList.getTotal();
	};
	$scope.subWargear = function(squad, unit, wargear, index) {
		Wargear.remove(squad, unit, wargear, index);
		$scope.armycost = SquadList.getTotal();
	};
}]);