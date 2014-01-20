function SetupCtrl($scope, $routeParams, $location, list) {
	$scope.user_id = $sid;

	$scope.routeParams = $routeParams;
	console.log("Setup", $scope.routeParams.id);

	var promise_unit_types = list.getAsync('GET', '/unit_types.json', {});
	$scope.unit_types = {};

	promise_unit_types.then(function( data ){
		$scope.unit_types = list.data;
	});


	var promise_my = list.getAsync('GET', '/view_army/'+$scope.routeParams.id+'.json', {});
	$scope.army = {};

	promise_my.then(function( data ){
		$scope.army = list.data;

		var promise_squads = list.getSecure('GET', '/squads/'+$scope.army.Races.id+'.json', {});
		$scope.squads = {};

		promise_squads.then(function( data ){
			$scope.squads = data;
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
		var eachmodel = [];
		for(var unit in $scope.currentDraggedSquad.Unit) {
			cost = cost + (parseInt($scope.currentDraggedSquad.Unit[unit].pts) * parseInt($scope.currentDraggedSquad.Unit[unit].SquadUnit.min_count));

			var find = $scope.unit_types.filter(function(unit_type) {
				return unit_type.UnitType.id == $scope.currentDraggedSquad.Unit[unit].unit_types_id
			});

			eachmodel[unit] = {
				'id': $scope.currentDraggedSquad.Unit[unit].id,
				'unitType': find[0].UnitType.name,
				'count': parseInt($scope.currentDraggedSquad.Unit[unit].SquadUnit.min_count)
			};

		}

		var thisunit = {
			'id': $scope.squad_list.length,
			'position': $scope.dropPos,
			'group': group,
			'total': cost,
			'data': $scope.currentDraggedSquad,
			'unit': eachmodel
		};

		$scope.squadPositionsOnAddition();

		$scope.$apply(function () {
			$scope.squad_list.push( thisunit );
		});

		element.remove();

		console.log($scope.squad_list);
	};

	$scope.squadPositionsOnAddition = function() {
		for(var i = 0; i < $scope.squad_list.length; i++) {
			if($scope.squad_list[i].position >= $scope.dropPos) {
				$scope.squad_list[i].position += 1;
			}
		}
	};

	$scope.squadPositionsOnSort = function() {

		var id = $scope.knownId.split("_");

		for(var i = 0; i < $scope.squad_list.length; i++) {

			if($scope.dropPos < $scope.startPos && $scope.squad_list[i].position >= $scope.dropPos && $scope.squad_list[i].position < $scope.startPos) {
				//down
				$scope.squad_list[i].position += 1;
			}

			if($scope.dropPos > $scope.startPos && $scope.squad_list[i].position <= $scope.dropPos && $scope.squad_list[i].position > $scope.startPos) {
				//up
				$scope.squad_list[i].position -= 1;
			}

		}

		$scope.squad_list[id[1]].position = $scope.dropPos;

	};

	$scope.addSquad = function(p_index, index, unit) {
		if($scope.squad_list[p_index].unit[index].count < unit.SquadUnit.max_count) {
			$scope.squad_list[p_index].unit[index].count++;
			$scope.squad_list[p_index].total += parseInt(unit.pts);
		}
	};

	$scope.subSquad = function(p_index, index, unit) {
		if($scope.squad_list[p_index].unit[index].count > unit.SquadUnit.min_count) {
			$scope.squad_list[p_index].unit[index].count--;
			$scope.squad_list[p_index].total -= parseInt(unit.pts);
		}
	};
}