function Squad() {
	var Id = 0;
	var Units = [];
	this.Group = "";
	var ArmyList = "";
	var Name = "";
	var Position = 0;
	var Total = 0;
	var chracteristics = [];
	var wargears = [];
	var Armour = false;

	this.setId = function(_Id) {
		Id = _Id;
	};
	this.getId = function() {
		return Id;
	};
	this.setArmyList = function(_ArmyList) {
		ArmyList = _ArmyList;
	};
	this.getArmyList = function() {
		return ArmyList;
	};
	this.setUnits = function(_SquadsUnit) {
		Units = _SquadsUnit;
	};
	this.getUnits = function() {
		return Units;
	};
	this.setName = function(_Name) {
		Name = _Name;
	};
	this.getName = function() {
		return Name;
	};
	this.setArmour = function(_Armour) {
		Armour = _Armour;
	};
	this.getArmour = function() {
		return Armour;
	};
	this.setPosition = function(_Position) {
		Position = _Position;
	};
	this.getPosition = function() {
		return Position;
	};
	this.setGroup = function(_Group) {
		this.Group = _Group;
	};
	this.getGroup = function() {
		return this.Group;
	};
	this.addTotal = function(_Total) {
		Total += parseInt(_Total, 0);
	};
	this.subTotal = function(_Total) {
		Total -= parseInt(_Total, 0);
	};
	this.getTotal = function() {
		return Total;
	};
	this.setCharacteristics = function(_characteristics) {
		chracteristics.push(_characteristics);
	};
	this.getCharacteristics = function() {
		return chracteristics;
	};
	this.setWargears = function(_wargears) {
		wargears.push(_wargears);
	};
	this.getWargears = function() {
		return wargears;
	};
	this.buildCharacteristics = function(_characteristics) {
		for(var chara in _characteristics) {
			if(chracteristics.indexOf(_characteristics[chara].name) == -1) {
				this.setCharacteristics(_characteristics[chara].name);
			}
		}
	};
	this.buildWargears = function(_wargears) {
		for(var war in _wargears) {
			if(wargears.indexOf(_wargears[war].name) == -1) {
				this.setWargears(_wargears[war].name);
			}
		}
	};
}