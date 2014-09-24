var Wargear = (function(){
	return {
		add: function(_parent, _obj, _item) {
			_obj.setArrayAttr("Equiped", _item);

			if(_item.unitupgrades !== null && _item.unitupgrades !== undefined) {
				switch(_item.unitupgrades.operation) {
					case "+":
						_obj.setUnitAttr(_item.unitupgrades.effected_column, (_obj.getUnitAttr(_item.unitupgrades.effected_column) + _item.unitupgrades.factor));
					break;
					case "*":
						_obj.setUnitAttr(_item.unitupgrades.effected_column, (_obj.getUnitAttr(_item.unitupgrades.effected_column) * _item.unitupgrades.factor));
					break;
					case "=":
						_obj.setUnitAttr(_item.unitupgrades.effected_column, _item.unitupgrades.factor);
					break;
				}
			}

			_parent.addTotal(_item.pts);
		},
		remove: function(_parent, _obj, _item, _index) {
			_obj.getAttr("Equiped").splice(_index, 1);

			if(_item.unitupgrades !== null && _item.unitupgrades !== undefined) {
				switch(_item.unitupgrades.operation) {
					case "+":
						_obj.setUnitAttr(_item.unitupgrades.effected_column, (_obj.getUnitAttr(_item.unitupgrades.effected_column) - _item.unitupgrades.factor));
					break;
					case "*":
						_obj.setUnitAttr(_item.unitupgrades.effected_column, (_obj.getUnitAttr(_item.unitupgrades.effected_column) / _item.unitupgrades.factor));
					break;
					case "=":
						_obj.setUnitAttr(_item.unitupgrades.effected_column, _obj.getBaseAttr(_item.unitupgrades.effected_column));
					break;
				}
			}

			_parent.subTotal(_item.pts);
		}
	};
})();