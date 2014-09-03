myApp.factory('squadbuilder', [function(){
	return {
		generate: function($scope) {
			SquadList.cleanSquad();
			var armysquads = $scope.army.ArmySquads;
			var squads = $scope.squads;

			if(armysquads !== undefined) {
				for(var ii = 0, jj = armysquads.length; ii < jj; ii++) {

					for(var i = 0, j = squads.length; i < j; i++) {
						if($scope.squads[i].id == armysquads[ii].squads_id) {
							var cost = 0;
							var Units = [];
							var squad = new Squad();

							var squadunit = squads[i].SquadUnits;

							for(var unit_index in squadunit) {
								var unit_count = armysquads[ii].ArmyUnits[unit_index].count;
								//cost = cost + (parseInt(squadunit[unit_index].Units.pts, 0) * parseInt(unit_count, 0));
								cost = cost + (parseInt(squadunit[unit_index].pts, 0) * parseInt(unit_count, 0));

								if(squadunit[unit_index].Units.front_armour !== 0) squad.setArmour(true);

								var unit = new Unit(squadunit[unit_index]);
								unit.setAttr("count", unit_count);
								Units.push(unit);

								squad.buildCharacteristics(squadunit[unit_index].UnitCharacteristics);
								squad.buildWargears(squadunit[unit_index].Wargears);

								squad.buildPsykers(squadunit[unit_index].Psykers);
								squad.buildRelics(squadunit[unit_index].Relics);
								squad.buildWarlords(squadunit[unit_index].Warlords);
								squad.buildTransports(squadunit[unit_index].Transports);

								if(armysquads[ii].ArmyUnits[unit_index].ArmyWargears !== undefined) {
									var wargears = armysquads[ii].ArmyUnits[unit_index].ArmyWargears;
									for(var iii = 0, jjj = wargears.length; iii < jjj; iii++) {
										var group = squadunit[unit_index].Groups;
										if(group !== undefined) {
											for(var a = 0, b = group.length; a < b; a++) {
												for(var c = 0, d = group[a].Wargears.length; c < d; c++) {
													if(wargears[iii].wargears_id === group[a].Wargears[c].id) {
														Wargear.add(squad, unit, group[a].Wargears[c]);
														break;
													}
												}
											}
										}
									}
								}
							}
							squad.setId(ii);
							squad.setPosition(parseInt(armysquads[ii].position, 0));
							squad.setSquadId(squads[i].id);
							//squad.setGroup(squads[i].type_name);
							squad.Group = squads[i].type_name;
							squad.addTotal(cost);
							squad.setUnits(Units);
							squad.setArmyList($scope.routeParams.id);
							squad.setName(squads[i].name);

							SquadList.setSquad(squad);

							break;
						}
					}
				}
			}

			$scope.squad_list = SquadList.getSquad();
			$scope.armycost = SquadList.getTotal();
			SquadList.orderSquads();
		},
		build: function($scope, group, element, drop) {
			var cost = 0;
			var Units = [];
			var squad = new Squad();

			if(drop === -1) {
				drop = SquadList.getSquad().length;
			} else {
				element.remove();
			}

			for(var unit_index in $scope.currentDraggedSquad.SquadUnits) {
				//cost = cost + (parseInt($scope.currentDraggedSquad.SquadUnits[unit_index].Units.pts, 0) * parseInt($scope.currentDraggedSquad.SquadUnits[unit_index].min_count, 0));
				cost = cost + (parseInt($scope.currentDraggedSquad.SquadUnits[unit_index].pts, 0) * parseInt($scope.currentDraggedSquad.SquadUnits[unit_index].min_count, 0));

				Units.push(new Unit($scope.currentDraggedSquad.SquadUnits[unit_index]));
				if($scope.currentDraggedSquad.SquadUnits[unit_index].Units.front_armour !== 0) squad.setArmour(true);

				squad.buildCharacteristics($scope.currentDraggedSquad.SquadUnits[unit_index].UnitCharacteristics);
				squad.buildWargears($scope.currentDraggedSquad.SquadUnits[unit_index].Wargears);

				squad.buildPsykers($scope.currentDraggedSquad.SquadUnits[unit_index].Psykers);
				squad.buildRelics($scope.currentDraggedSquad.SquadUnits[unit_index].Relics);
				squad.buildWarlords($scope.currentDraggedSquad.SquadUnits[unit_index].Warlords);
				squad.buildTransports($scope.currentDraggedSquad.SquadUnits[unit_index].Transports);
			}

			//squad.setId($scope.currentDraggedSquad.id);
			squad.setId(SquadList.getSquad().length);
			squad.setSquadId($scope.currentDraggedSquad.id);
			squad.setPosition(drop);
			squad.setGroup(group);
			squad.addTotal(cost);
			squad.setUnits(Units);
			squad.setArmyList($scope.routeParams.id);
			squad.setName($scope.currentDraggedSquad.name);

			SquadList.squadPositionsOnAction(drop, true);

			$scope.$apply(function () {
				SquadList.setSquad(squad);
				$scope.squad_list = SquadList.getSquad();
				$scope.armycost = SquadList.getTotal();
				SquadList.orderSquads();
			});
		}
	};
}]);