function SetupCtrl($scope, $routeParams, $location, list) {
	$scope.user_id = $sid;

	$scope.routeParams = $routeParams;
	$scope.armycost = 0;

	var promise_unit_types = list.getAsync('GET', '/types.json', {});
	$scope.unit_types = {};

	promise_unit_types.then(function( data ){
		$scope.unit_types = list.data;
	});


	var promise_my = list.getAsync('GET', '/view_army/'+$scope.routeParams.id+'.json', {});
	$scope.army = {};

	promise_my.then(function( data ){
		$scope.army = list.data.ArmyLists;

		var promise_squads = list.getSecure('GET', '/squads_units/'+$scope.army.armies_id+'.json', {});
		$scope.squads = {};

		promise_squads.then(function( data ){
			$scope.squads = data.Squads;
		});

	});

	$scope.currentDraggedSquad = null;
	$scope.squad_list = [];
	$scope.getSquad = function() {
		$scope.currentDraggedSquad = this.squad;
	};
	$scope.dropPos = 0;
	$scope.startPos = 0;
	$scope.knownId = null;


	$scope.squadBuilder = function(group, element) {
		var cost = 0;
		var Units = [];
		var squad = new Squad();

		for(var unit_index in $scope.currentDraggedSquad.SquadUnits) {
			cost = cost + (parseInt($scope.currentDraggedSquad.SquadUnits[unit_index].Units.pts, 0) * parseInt($scope.currentDraggedSquad.SquadUnits[unit_index].min_count, 0));

			Units.push(new Unit($scope.currentDraggedSquad.SquadUnits[unit_index]));
			squad.buildCharacteristics($scope.currentDraggedSquad.SquadUnits[unit_index].Units.UnitCharacteristics);
			squad.buildWargears($scope.currentDraggedSquad.SquadUnits[unit_index].Units.Wargears);
		}

		squad.setId($scope.squad_list.length);
		squad.setGroup(group);
		squad.addTotal(cost);
		squad.setUnits(Units);
		squad.setName($scope.currentDraggedSquad.name);



		$scope.$apply(function () {
			SquadList.setSquad(squad);
			$scope.squad_list = SquadList.getSquad();
			$scope.armycost = SquadList.getTotal();
		});

		element.remove();

	};

	$scope.squadPositionsOnSort = function() {
		SquadList.squadPositionsOnSort($scope.knownId, $scope.dropPos, $scope.startPos);

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
}