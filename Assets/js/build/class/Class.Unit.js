function Unit(UnitInfo) {
	this.id = parseInt(UnitInfo.units.id, 0);
	var data = {
		min_count: parseInt(UnitInfo.min_count, 0),
		max_count: parseInt(UnitInfo.max_count, 0),
		count: parseInt(UnitInfo.min_count, 0),
		pts: parseInt(UnitInfo.pts, 0),
		Groups: UnitInfo.groups,
		Equiped: [],
		Unit: {
			name: UnitInfo.name,
			unittype: UnitInfo.units.unittype,
			weapon_skill: parseInt(UnitInfo.units.weapon_skill, 0),
			ballistic_skill: parseInt(UnitInfo.units.ballistic_skill, 0),
			strength: parseInt(UnitInfo.units.strength, 0),
			toughness: parseInt(UnitInfo.units.toughness, 0),
			wounds: parseInt(UnitInfo.units.wounds, 0),
			attacks: parseInt(UnitInfo.units.attacks, 0),
			initiative: parseInt(UnitInfo.units.initiative, 0),
			leadership: parseInt(UnitInfo.units.leadership, 0),
			armour_save: parseInt(UnitInfo.units.armour_save, 0),
			invulnerable_save: parseInt(UnitInfo.units.invulnerable_save, 0),
			front_armour: parseInt(UnitInfo.units.front_armour, 0),
			side_armour: parseInt(UnitInfo.units.side_armour, 0),
			rear_armour: parseInt(UnitInfo.units.rear_armour, 0),
			hull_hitpoints: parseInt(UnitInfo.units.hull_hitpoints, 0),
			//pts: parseInt(UnitInfo.units.pts, 0)
		},
		Base: {
			name: UnitInfo.name,
			unittype: UnitInfo.units.unittype,
			weapon_skill: parseInt(UnitInfo.units.weapon_skill, 0),
			ballistic_skill: parseInt(UnitInfo.units.ballistic_skill, 0),
			strength: parseInt(UnitInfo.units.strength, 0),
			toughness: parseInt(UnitInfo.units.toughness, 0),
			wounds: parseInt(UnitInfo.units.wounds, 0),
			attacks: parseInt(UnitInfo.units.attacks, 0),
			initiative: parseInt(UnitInfo.units.initiative, 0),
			leadership: parseInt(UnitInfo.units.leadership, 0),
			armour_save: parseInt(UnitInfo.units.armour_save, 0),
			invulnerable_save: parseInt(UnitInfo.units.invulnerable_save, 0),
			front_armour: parseInt(UnitInfo.units.front_armour, 0),
			side_armour: parseInt(UnitInfo.units.side_armour, 0),
			rear_armour: parseInt(UnitInfo.units.rear_armour, 0),
			hull_hitpoints: parseInt(UnitInfo.units.hull_hitpoints, 0)
		}

	};

	this.getUnitAttr = function(_field) {
		return data.Unit[_field];
	};
	this.setUnitAttr = function(_field, _value) {
		data.Unit[_field] = _value;
	};
	this.getBaseAttr = function(_field) {
		return data.Base[_field];
	};
	this.setBaseAttr = function(_field, _value) {
		data.Base[_field] = _value;
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