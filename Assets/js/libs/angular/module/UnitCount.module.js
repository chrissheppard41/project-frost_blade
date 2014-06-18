var UnitCount = (function(){
	return {
		add: function(parent, obj) {
			count = obj.getAttr("count") + 1;
			obj.setAttr("count", count);

			parent.addTotal(obj.getUnitAttr("pts"));
		},
		sub: function(parent, obj) {
			count = obj.getAttr("count") - 1;
			obj.setAttr("count", count);

			parent.subTotal(obj.getUnitAttr("pts"));
		}
	};
})();