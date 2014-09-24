myApp.factory('squadbuilder', [function(){
	return {
		generate: function($scope) {
			SquadList.cleanSquad();
			var armysquads = $scope.army.armysquads;
			var squads = $scope.squads;

			if(armysquads !== undefined) {
				for(var ii = 0, jj = armysquads.length; ii < jj; ii++) {

					for(var i = 0, j = squads.length; i < j; i++) {
						if($scope.squads[i].id == armysquads[ii].squads_id) {
							var cost = 0;
							var units = [];
							var squad = new Squad();

							var squadunit = squads[i].squadunits;

							for(var unit_index in squadunit) {
								var unit_count = armysquads[ii].armyunits[unit_index].count;
								//cost = cost + (parseInt(squadunit[unit_index].units.pts, 0) * parseInt(unit_count, 0));
								cost = cost + (parseInt(squadunit[unit_index].pts, 0) * parseInt(unit_count, 0));

								if(squadunit[unit_index].units.front_armour !== 0) squad.setArmour(true);

								var unit = new Unit(squadunit[unit_index]);
								unit.setAttr("count", unit_count);
								units.push(unit);

								squad.buildCharacteristics(squadunit[unit_index].unitcharacteristics);
								squad.buildWargears(squadunit[unit_index].wargears);

								squad.buildPsykers(squadunit[unit_index].psykers);
								squad.buildRelics(squadunit[unit_index].relics);
								squad.buildWarlords(squadunit[unit_index].warlords);
								squad.buildTransports(squadunit[unit_index].transports);

								if(armysquads[ii].armyunits[unit_index].armywargears !== undefined) {
									var wargears = armysquads[ii].armyunits[unit_index].armywargears;
									for(var iii = 0, jjj = wargears.length; iii < jjj; iii++) {
										var group = squadunit[unit_index].groups;

										if(group !== undefined) {
											for(var a = 0, b = group.length; a < b; a++) {
												for(var c = 0, d = group[a].wargears.length; c < d; c++) {
													if(wargears[iii].wargears_id === group[a].wargears[c].id) {
														Wargear.add(squad, unit, group[a].wargears[c]);
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
							squad.setUnits(units);
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
			var units = [];
			var squad = new Squad();

			if(drop === -1) {
				drop = SquadList.getSquad().length;
			} else {
				element.remove();
			}

			for(var unit_index in $scope.currentDraggedSquad.squadunits) {
				//cost = cost + (parseInt($scope.currentDraggedSquad.squadunits[unit_index].units.pts, 0) * parseInt($scope.currentDraggedSquad.squadunits[unit_index].min_count, 0));
				cost = cost + (parseInt($scope.currentDraggedSquad.squadunits[unit_index].pts, 0) * parseInt($scope.currentDraggedSquad.squadunits[unit_index].min_count, 0));

				units.push(new Unit($scope.currentDraggedSquad.squadunits[unit_index]));
				if($scope.currentDraggedSquad.squadunits[unit_index].units.front_armour !== 0) squad.setArmour(true);

				squad.buildCharacteristics($scope.currentDraggedSquad.squadunits[unit_index].unitcharacteristics);
				squad.buildWargears($scope.currentDraggedSquad.squadunits[unit_index].wargears);

				squad.buildPsykers($scope.currentDraggedSquad.squadunits[unit_index].psykers);
				squad.buildRelics($scope.currentDraggedSquad.squadunits[unit_index].relics);
				squad.buildWarlords($scope.currentDraggedSquad.squadunits[unit_index].warlords);
				squad.buildTransports($scope.currentDraggedSquad.squadunits[unit_index].transports);
			}

			//squad.setId($scope.currentDraggedSquad.id);
			squad.setId(SquadList.getSquad().length);
			squad.setSquadId($scope.currentDraggedSquad.id);
			squad.setPosition(drop);
			squad.setGroup(group);
			squad.addTotal(cost);
			squad.setUnits(units);
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