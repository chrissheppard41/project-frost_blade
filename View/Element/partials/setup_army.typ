<section class="clearfix">
	<article>
		<h2>Setup <span><a href="#/" class="back">Back</a></span></h2>

		<p>Army cost: {{armycost}}</p>

		<div ng-repeat="unit_types in unit_types" class="section">
			<div class="col1">
				<div class="panel {{unit_types.name | groups}}">
					<div class="panel-heading">{{unit_types.name}} </div>
					<div class="panel-body" ng-drop id="drop{{unit_types.name}}" ng-accept=".{{unit_types.name.toLowerCase()}}">
						<aside ng-repeat="squad in squad_list | filter:{Group:unit_types.name}" class="drag_container unit_container" id="{{squad.getGroup()}}_{{squad.getId()}}">
							<h3>{{squad.getName()}} <a href="" ng-click="removeSquad(squad.getId(), squad.getPosition())">Remove</a> <span>{{squad.getTotal()}} pts</span></h3>

							<dl ng-hide="squad.getArmour()" class="header">
								<dd>Count</dd>
								<dd>WS</dd>
								<dd>BS</dd>
								<dd>S</dd>
								<dd>T</dd>
								<dd>W</dd>
								<dd>I</dd>
								<dd>A</dd>
								<dd>Ld</dd>
								<dd>Sv</dd>
								<dd>Ls</dd>
								<dd>Unit type</dd>
							</dl>
							<dl ng-show="squad.getArmour()" class="header">
								<dd>Count</dd>
								<dd>WS</dd>
								<dd>BS</dd>
								<dd>S</dd>
								<dd>FA</dd>
								<dd>SA</dd>
								<dd>RA</dd>
								<dd>I</dd>
								<dd>A</dd>
								<dd>HP</dd>
								<dd>Ls</dd>
								<dd>Unit type</dd>
							</dl>

							<dl ng-hide="squad.getArmour()"  ng-repeat="unit in squad.getUnits()">
								<dd>{{unit.getUnitAttr("name")}}</dd>
								<dd>
									<button class="sub" ng-click="subSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('min_count')">-</button>
									{{unit.getAttr("count")}}
									<button class="add" ng-click="addSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('max_count')">+</button>
								</dd>

								<dd>{{unit.getUnitAttr("weapon_skill")}}</dd>
								<dd>{{unit.getUnitAttr("ballistic_skill")}}</dd>
								<dd>{{unit.getUnitAttr("strength")}}</dd>
								<dd>{{unit.getUnitAttr("toughness")}}</dd>
								<dd>{{unit.getUnitAttr("wounds")}}</dd>
								<dd>{{unit.getUnitAttr("initiative")}}</dd>
								<dd>{{unit.getUnitAttr("attacks")}}</dd>
								<dd>{{unit.getUnitAttr("leadership")}}</dd>
								<dd>{{unit.getUnitAttr("armour_save")}}+</dd>
								<dd>{{unit.getUnitAttr("invulnerable_save")}}+</dd>
								<dd>{{unit.getUnitAttr("unittype")}}</dd>

								<dd>
									<div class="wargears" ng-repeat="group in unit.getAttr('Groups')">
										<span>{{group.name}}</span>
										<span>
											<select ng-options="g.pts+'pts - '+g.name for g in group.Wargears" ng-model="selectedItem"></select>
										</span>
										<a href="" ng-click="addWargear(squad, unit)">+</a>
									</div>
								</dd>
							</dl>

							<dl ng-show="squad.getArmour()"  ng-repeat="unit in squad.getUnits()">
								<dd>{{unit.getUnitAttr("name")}}</dd>
								<dd>
									<button class="sub" ng-click="subSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('min_count')">-</button>
									{{unit.getAttr("count")}}
									<button class="add" ng-click="addSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('max_count')">+</button>
								</dd>

								<dd>{{unit.getUnitAttr("weapon_skill")}}</dd>
								<dd>{{unit.getUnitAttr("ballistic_skill")}}</dd>
								<dd>{{unit.getUnitAttr("strength")}}</dd>
								<dd>{{unit.getUnitAttr("front_armour")}}</dd>
								<dd>{{unit.getUnitAttr("side_armour")}}</dd>
								<dd>{{unit.getUnitAttr("rear_armour")}}</dd>
								<dd>{{unit.getUnitAttr("initiative")}}</dd>
								<dd>{{unit.getUnitAttr("attacks")}}</dd>
								<dd>{{unit.getUnitAttr("hull_hitpoints")}}</dd>
								<dd>{{unit.getUnitAttr("invulnerable_save")}}+</dd>
								<dd>{{unit.getUnitAttr("unittype")}}</dd>

								<dd>
									<div class="wargears" ng-repeat="group in unit.getAttr('Groups')">
										<span>{{group.name}}</span>
										<span>
											<select ng-options="g.pts+'pts - '+g.name for g in group.Wargears" ng-model="selectedItem"></select>
										</span>
										<a href="" ng-click="addWargear(squad, unit)">+</a>
									</div>
								</dd>
							</dl>

							<div class="col3">
								<div>
									<h4>Wargear</h4>
									<ul>
										<li ng-repeat="wargear in squad.getWargears()">{{wargear}}</li>
									</ul>
								</div>
								<div>
									<h4>Special rules</h4>
									<ul>
										<li ng-repeat="character in squad.getCharacteristics()">{{character}}</li>
									</ul>
								</div>
								<div>
									<h4>Additional wargear</h4>
									<ul ng-repeat="unitdata in squad.getUnits()">
										<li ng-repeat="wargear in unitdata.getAttr('Equiped')">
											{{wargear.name}}
											<a href="" ng-click="subWargear(squad, unitdata, wargear, $index)">-</a>
										</li>
									</ul>
								</div>
							</div>
						</aside>

					</div>
					<div class="panel-footer"><span>Drop here</span></div>
				</div>
			</div>
			<div class="col2">
				<div class="panel {{unit_types.name | groups}}">
					<div class="panel-heading">{{unit_types.name}} units</div>
					<div class="panel-body">
						<ul>
							<li ng-repeat="squad in squads | filter:{type_name:unit_types.name}" class="drag_container" id="{{squad.id}}">
								<aside ng-drag class="a-drag {{unit_types.name.toLowerCase()}} unit_data" ng-accept="#drop{{unit_types.name}}">{{squad.name}}</aside>
							</li>
						</ul>
					</div>
				</div>
			</div>

		</div>

<!--ul class="clearList">
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
</div-->

		<form ng-submit="submit_army()" class="form-horizontal" name="setup_army_list" id="ArmyList#Form" method="POST" accept-charset="utf-8">
			<span>
				<button class="btn btn-primary">Save</button>
			</span>
		</form>

	</article>
</section>