function Unit(UnitInfo) {
	this.id = parseInt(UnitInfo.Units.id, 0);
	var data = {
		min_count: parseInt(UnitInfo.min_count, 0),
		max_count: parseInt(UnitInfo.max_count, 0),
		count: parseInt(UnitInfo.min_count, 0),
		Groups: UnitInfo.Groups,
		Equiped: [],
		Unit: {
			name: UnitInfo.Units.name,
			unittype: UnitInfo.Units.unittype,
			weapon_skill: parseInt(UnitInfo.Units.weapon_skill, 0),
			ballistic_skill: parseInt(UnitInfo.Units.ballistic_skill, 0),
			strength: parseInt(UnitInfo.Units.strength, 0),
			toughness: parseInt(UnitInfo.Units.toughness, 0),
			wounds: parseInt(UnitInfo.Units.wounds, 0),
			attacks: parseInt(UnitInfo.Units.attacks, 0),
			initiative: parseInt(UnitInfo.Units.initiative, 0),
			leadership: parseInt(UnitInfo.Units.leadership, 0),
			armour_save: parseInt(UnitInfo.Units.armour_save, 0),
			invulnerable_save: parseInt(UnitInfo.Units.invulnerable_save, 0),
			pts: parseInt(UnitInfo.Units.pts, 0)
		}

	};

	this.getUnitAttr = function(_field) {
		return data.Unit[_field];
	};
	this.setUnitAttr = function(_field, _value) {
		data.Unit[_field] = _value;
	};
	this.getAttr = function(_field) {
		return data[_field];
	};
	this.setAttr = function(_field, _value) {
		data[_field] = _value;
	};
	this.setArrayAttr = function(_field, _value) {
		data[_field].push(_value);
	};
	this.getAllAttr = function() {
		return data;
	};
}