<section class="clearfix">
	<article>
		<h2>Setup <span><a href="javascript:history.go(-1)" class="back">Back</a></span></h2>

		<p>Army cost: {{armycost}} pts</p>

		<div ng-repeat="unit_types in unit_types" class="section">
			<div class="col1">

				<div class="panel {{unit_types.name | groups}} click">
					<div class="panel-heading">{{unit_types.name}} units</div>
					<div class="panel-body">
						<ul class="tab_list">
							<li ng-repeat="squad in squads | filter:{type_name:unit_types.name}" id="{{squad.id}}" class="{{unit_types.name.toLowerCase()}}" ng-click-add>{{squad.name}}</li>
						</ul>
					</div>
				</div>

				<div class="panel {{unit_types.name | groups}}">
					<div class="panel-heading">{{unit_types.name | replace}} </div>
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
									<button class="sub" ng-click="subSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('min_count')"><i>&nbsp;</i></button>
									{{unit.getAttr("count")}}
									<button class="add" ng-click="addSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('max_count')"><i>&nbsp;</i></button>
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
											<select ng-options="g.pts+'pts - '+g.name for g in group.wargears" ng-model="selectedItem"></select>
										</span>
										<a href="" class="blue" ng-click="addWargear(squad, unit)"><i>&nbsp;</i></a>
									</div>
								</dd>
							</dl>

							<dl ng-show="squad.getArmour()"  ng-repeat="unit in squad.getUnits()">
								<dd>{{unit.getUnitAttr("name")}}</dd>
								<dd>
									<button class="sub" ng-click="subSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('min_count')"><i>&nbsp;</i></button>
									{{unit.getAttr("count")}}
									<button class="add" ng-click="addSquad(squad, unit)" ng-disabled="unit.getAttr('count') == unit.getAttr('max_count')"><i>&nbsp;</i></button>
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
											<select ng-options="g.pts+'pts - '+g.name for g in group.wargears" ng-model="selectedItem"></select>
										</span>
										<a href="" class="blue" ng-click="addWargear(squad, unit)"><i>&nbsp;</i></a>
									</div>
								</dd>
							</dl>

							<div class="col3">
								<div ng-show="squad.getWargears().length">
									<h4>Wargear</h4>
									<ul>
										<li ng-repeat="wargear in squad.getWargears()">{{wargear}}</li>
									</ul>
								</div>
								<div ng-show="squad.getCharacteristics().length">
									<h4>Special rules</h4>
									<ul>
										<li ng-repeat="character in squad.getCharacteristics()">{{character}}</li>
									</ul>
								</div>
								<div ng-show="squad.getPsykers().length">
									<h4>Psyker Abilities</h4>
									<ul>
										<li ng-repeat="psyker in squad.getPsykers()">{{psyker}}</li>
									</ul>
								</div>
								<div ng-show="squad.getRelics().length">
									<h4>Relics</h4>
									<ul>
										<li ng-repeat="relic in squad.getRelics()">{{relic}}</li>
									</ul>
								</div>
								<div ng-show="squad.getWarlords().length">
									<h4>Warlord traits</h4>
									<ul>
										<li ng-repeat="warlord in squad.getWarlords()">{{warlord}}</li>
									</ul>
								</div>
								<div ng-show="squad.getTransports().length">
									<h4>Transport capacity</h4>
									<ul>
										<li ng-repeat="transport in squad.getTransports()">{{transport}}</li>
									</ul>
								</div>
								<div>
									<h4>Additional wargear</h4>
									<ul ng-repeat="unitdata in squad.getUnits()">
										<li ng-repeat="wargear in unitdata.getAttr('Equiped') track by $index">
											{{wargear.name}}
											<a href="" ng-click="subWargear(squad, unitdata, wargear, $index)"><i>&nbsp;</i></a>
										</li>
									</ul>
								</div>
							</div>
						</aside>

					</div>
					<div class="panel-footer"><span>Drop here</span></div>
				</div>
			</div>
			<div class="col2 drags">
				<div class="panel {{unit_types.name | groups}}">
					<div class="panel-heading">{{unit_types.name | replace}} units</div>
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

		<form ng-submit="submit_army()" class="form-horizontal" name="setup_army_list" id="ArmyList#Form" method="POST" accept-charset="utf-8">
			<span>
				<button class="btn btn-primary">Save</button>
			</span>
		</form>

	</article>
</section>