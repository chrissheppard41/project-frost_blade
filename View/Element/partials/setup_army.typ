<section class="clearfix">
	<h2>Setup</h2>
	<a href="#/" class="btn btn-danger">back</a>

	<p>Army cost: {{armycost}}</p>

	<ul class="clearList">
		<li ng-repeat="squad in squads" class="drag_container" id="{{squad.id}}">
			<div ng-drag class="a-drag troops unit_data" ng-accept=".dropTroops">
				{{squad.name}}
			</div>
		</li>
	</ul>


	<div ng-drop class="dropTroops" ng-accept=".troops">
		Drop area

		<div ng-repeat="squad in squad_list" class="drag_container" id="{{squad.group}}_{{squad.id}}">
			{{squad.getName()}}
			<div class="content">

				<span class="cost">{{squad.getTotal()}} pts</span>

				<dl class="row">
					<dd class="col-md-offset-2 col-md-1">Unit Count</dd>
					<dd class="col-md-1">WS</dd>
					<dd class="col-md-1">BS</dd>
					<dd class="col-md-1">S</dd>
					<dd class="col-md-1">T</dd>
					<dd class="col-md-1">W</dd>
					<dd class="col-md-1">I</dd>
					<dd class="col-md-1">A</dd>
					<dd class="col-md-1">Ld</dd>
					<dd class="col-md-1">Sv</dd>
				</dl>
				<dl class="row" ng-repeat="unit in squad.getUnits()">
					<dd class="col-md-2">{{unit.getUnitAttr("name")}} ({{unit.getUnitAttr("unittype")}})</dd>
					<dd class="col-md-1">
						<button class="btn-xs btn-danger" ng-click="subSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('min_count')"><span class="glyphicon glyphicon-minus"></span></button>
						{{unit.getAttr("count")}}
						<button class="btn-xs btn-primary" ng-click="addSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('max_count')"><span class="glyphicon glyphicon-plus"></span></button>
					</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("weapon_skill")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("ballistic_skill")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("strength")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("toughness")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("wounds")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("initiative")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("attacks")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("leadership")}}</dd>
					<dd class="col-md-1">{{unit.getUnitAttr("armour_save")}}+</dd>

						<dd class="col-md-12">Upgrade options<br />
							<ul>
								<li ng-repeat="group in unit.getAttr('Groups')">
									{{group.name}}
									<select ng-options="g.pts+'pts - '+g.name for g in group.Wargears" ng-model="selectedItem" class="col-md-5"></select>
									<button class="btn-xs btn-primary" ng-click="addWargear(squad, unit)"><span class="glyphicon glyphicon-plus"></span></button>
								</li>
							</ul>
						</dd>
				</dl>
				<dl class="row">
					<dd>
						Special rules<br />
						{{ squad.getCharacteristics() | joinBy:', ' }}
					</dd>
					<dd>
						Wargear<br />
						{{ squad.getWargears() | joinBy:', ' }}
					</dd>
					<dd>
						Additional wargear:<br />
						<span ng-repeat="unitdata in squad.getUnits()">
							<span ng-repeat="wargear in unitdata.getAttr('Equiped')">
								{{wargear.name}}
								<button class="btn-xs btn-danger" ng-click="subWargear(squad, unitdata, wargear, $index)"><span class="glyphicon glyphicon-minus"></span></button>
							</span>
						</span>
					</dd>
				</dl>
			</div>
		</div>
	</div>

</section>