var Wargear = (function(){
	return {
		add: function(_parent, _obj, _item) {
			_obj.setArrayAttr("Equiped", _item);

			if(_item.UnitUpgrades !== null && _item.UnitUpgrades !== undefined) {
				switch(_item.UnitUpgrades.operation) {
					case "+":
						_obj.setUnitAttr(_item.UnitUpgrades.effected_column, (_obj.getUnitAttr(_item.UnitUpgrades.effected_column) + _item.UnitUpgrades.factor));
					break;
					case "*":
						_obj.setUnitAttr(_item.UnitUpgrades.effected_column, (_obj.getUnitAttr(_item.UnitUpgrades.effected_column) * _item.UnitUpgrades.factor));
					break;
				}
			}

			_parent.addTotal(_item.pts);
		},
		remove: function(_parent, _obj, _item, _index) {
			_obj.getAttr("Equiped").splice(_index, 1);

			if(_item.UnitUpgrades !== null && _item.UnitUpgrades !== undefined) {
				switch(_item.UnitUpgrades.operation) {
					case "+":
						_obj.setUnitAttr(_item.UnitUpgrades.effected_column, (_obj.getUnitAttr(_item.UnitUpgrades.effected_column) - _item.UnitUpgrades.factor));
					break;
					case "*":
						_obj.setUnitAttr(_item.UnitUpgrades.effected_column, (_obj.getUnitAttr(_item.UnitUpgrades.effected_column) / _item.UnitUpgrades.factor));
					break;
				}
			}

			_parent.subTotal(_item.pts);
		}
	};
})();