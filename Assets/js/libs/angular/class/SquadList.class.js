var SquadList = (function() {
	var Squads = [];

	return {
		setSquad: function(_Squads) {
			Squads.push(_Squads);
		},
		getSquad: function() {
			return Squads;
		},
		getTotal: function() {
			var ArmyCost = 0;
			for(var count in Squads) {
				ArmyCost += Squads[count].getTotal();
			}

			return ArmyCost;
		},
		squadPositionsOnAddition: function(dropPos) {
			for(var i = 0; i < Squads.length; i++) {
				if(Squads[i].position >= dropPos) {
					Squads[i].position += 1;
				}
			}
		},
		squadPositionsOnSort: function(knownId, dropPos, startPos) {
			var id = knownId.split("_");

			for(var i = 0; i < Squads.length; i++) {

				if(dropPos < startPos && Squads[i].position >= dropPos && Squads[i].position < startPos) {
					//down
					Squads[i].position += 1;
				}

				if(dropPos > startPos && Squads[i].position <= dropPos && Squads[i].position > startPos) {
					//up
					Squads[i].position -= 1;
				}

			}

			Squads[id[1]].position = dropPos;

		}
	};

}());