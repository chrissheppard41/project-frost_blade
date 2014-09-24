<section class="clearfix">
	<article>
		<h2>Army setup - {{army.name}} <span><a href="javascript:history.go(-1)" class="back">Back</a></span><!--span><a href="" class="toggle" ng-toggle>Toggle Print view</a></span--></h2>

		<div class="section">

			<div class="col1">

				<div ng-repeat="unit_types in unit_types" class="panel {{unit_types.name | groups}}">
					<div class="panel-heading">{{unit_types.name | replace}} </div>
					<div class="panel-body" ng-accept=".{{unit_types.name.toLowerCase()}}">
						<aside ng-repeat="squad in squad_list | filter:{Group:unit_types.name}" class="unit_container" id="{{squad.getGroup()}}_{{squad.getId()}}">
							<h3>{{squad.getName()}} <span>{{squad.getTotal()}} pts</span></h3>

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
								<dd>{{unit.getAttr("count")}}</dd>
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
							</dl>

							<dl ng-show="squad.getArmour()"  ng-repeat="unit in squad.getUnits()">
								<dd>{{unit.getUnitAttr("name")}}</dd>
								<dd>{{unit.getAttr("count")}}</dd>
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
										<li ng-repeat="wargear in unitdata.getAttr('Equiped') track by $index">
											{{wargear.name}}
										</li>
									</ul>
								</div>
							</div>
						</aside>
					</div>
				</div>



			</div>
			<div class="col2">


				<div class="panel blue">
					<div class="panel-heading">
						<?php echo $this->Html->__t('Army setup information'); ?>

					</div>
					<div class="panel-body">
						<div>
							<?php echo $this->Html->__t('Name'); ?>
							<span>{{army.name}}</span>
						</div>
						<div>
							<?php echo $this->Html->__t('Description'); ?>
							<span>{{army.descr}}</span>
						</div>
						<div>
							<?php echo $this->Html->__t('Army points'); ?>
							<span>{{armycost}} pts</span>
						</div>
						<div>
							<?php echo $this->Html->__t('Point Limit'); ?>
							<span>{{army.point_limit}} pts</span>
						</div>
						<div>
							<?php echo $this->Html->__t('Hidden'); ?>
							<span>{{army.hide | hidden}}</span>
						</div>
						<div>
							<?php echo $this->Html->__t('Army'); ?>
							<span>{{army.army_name}}</span>
						</div>
						<div>
							<?php echo $this->Html->__t('Created'); ?>
							<span>{{dateMomment(army.created)}}</span>
						</div>
						<div>
							<?php echo $this->Html->__t('Modified'); ?>
							<span>{{dateMomment(army.modified)}}</span>
						</div>
						<div class="votes">
							<span>
								<a href="" class="blue{{army.vote | active:'up'}} up_" ng-click="votes(army.code, 'up')"><i>&nbsp;</i></a>
								<a href="" class="red{{army.vote | active:'down'}} down_" ng-click="votes(army.code, 'down')"><i>&nbsp;</i></a>
							</span>
							<span>
								<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
								<span class="count">{{army.score}}</span>
							</span>
							<span ng-show="army.users_id == user_id">
							</span>
						</div>

					</div>
				</div>

			</div>

		</div>


	</article>
</section>