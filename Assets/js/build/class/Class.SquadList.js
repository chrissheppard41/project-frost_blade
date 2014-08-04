var SquadList = (function() {
	var Squads = [];
	var ArmyList = 0;
	var postUnit = [];
	var postWargear = [];

	return {
		setSquad: function(_Squads) {
			Squads.push(_Squads);
		},
		getSquad: function() {
			return Squads;
		},
		submitSquad: function() {
			var postSquad = [];
			for(var s_index in Squads) {
				postUnit = [];

				var units = Squads[s_index].getUnits();
				for(var u_index in units) {
					postWargear = [];

					var wargears = units[u_index].getAttr("Equiped");
					for(var w_index in wargears) {
						postWargear[w_index] = {
							wargears_id: wargears[w_index].id
						};
					}

					postUnit[u_index] = {
						units_id: units[u_index].id,
						count: units[u_index].getAttr("count"),
						ArmyWargears: postWargear
					};
				}

				postSquad[s_index] = {
					squads_id: Squads[s_index].getId(),
					armylists_id: Squads[s_index].getArmyList(),
					position: Squads[s_index].getPosition(),
					ArmyUnits: postUnit
				};

			}
			return {"ArmySquads": postSquad};
		},
		getTotal: function() {
			var ArmyCost = 0;
			for(var count in Squads) {
				ArmyCost += Squads[count].getTotal();
			}

			return ArmyCost;
		},
		cleanSquad: function() {
			Squads = [];
		},
		orderSquads: function() {
			Squads.sort(function(a, b) {
				if(a.getPosition() < b.getPosition())
					return -1;
				if(a.getPosition() > b.getPosition())
					return 1;
				return 0;
			});
		},
		squadPositionsOnAction: function(dropPos, add) {
			for(var i = 0; i < Squads.length; i++) {
				if(Squads[i].getPosition() >= dropPos) {
					if(add) {
						Squads[i].setPosition((Squads[i].getPosition() + 1));
					} else {
						Squads[i].setPosition((Squads[i].getPosition() - 1));
					}

				}
			}
		},
		squadPositionsOnSort: function(knownId, dropPos, startPos) {
			var id = knownId.split("_");

			for(var i = 0; i < Squads.length; i++) {

				if(dropPos < startPos && Squads[i].getPosition() >= dropPos && Squads[i].getPosition() < startPos) {
					//down
					Squads[i].setPosition(Squads[i].getPosition() + 1);
				}

				if(dropPos > startPos && Squads[i].getPosition() <= dropPos && Squads[i].getPosition() > startPos) {
					//up
					Squads[i].setPosition(Squads[i].getPosition() - 1);
				}

			}

			Squads[id[1]].setPosition(dropPos);
		},
		removeSquad: function(id, pos) {
			for(var i = 0; i < Squads.length; i++) {

				if(Squads[i].getId() === id) {
					Squads.splice(i,1);
				}
			}
			this.squadPositionsOnAction(pos, false);

		}
	};

}());