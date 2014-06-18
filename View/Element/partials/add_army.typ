<section class="clearfix">
	<h2>Add</h2>
	<a href="#/" class="btn btn-danger">back</a>
	<div class="error" ng-bind-html-unsafe="formMessage">{{formMessage}}</div>

	<form ng-submit="submit_add()" class="form-horizontal" name="add_army_list" id="ArmyList#Form" method="POST" accept-charset="utf-8">
		<p class="add_step_1">
			<span class="form-group required">
				<label for="name" class="col-lg-2 control-label text-right">Race</label>
				<span class="col-lg-10 pull-right">
					<select ng-model="race" ng-change="dis_races()" name="data[ArmyLists][races_id]" class="form-control">
						<option ng-repeat="type in Races.Races" value="{{$index}}">{{type.name}}</option>
					</select>
				</span>
			</span>
		</p>
		<p class="add_step_2" ng-hide="step_2_view">
			<span class="form-group required">
				<label for="name" class="col-lg-2 control-label text-right">Army</label>
				<span class="col-lg-10 pull-right">
					<select ng-model="army" ng-change="dis_squads()" name="data[ArmyLists][armies_id]" class="form-control">
						<option ng-repeat="army in armies" value="{{army.id}}">{{army.name}}</option>
					</select>
				</span>
			</span>
		</p>
		<p class="add_step_3" ng-hide="step_3_view">
			<ul>
				<li ng-repeat="squad in squads" id="{{squad.id}}">{{squad.type_name}} - {{squad.name}}</li>
			</ul>
		</p>
		<p class="add_step_4" ng-hide="step_3_view">
			<span class="form-group required">
				<label for="name" class="col-lg-2 control-label text-right">Name<span class="error" ng-show="add_army_list.name.$error.required"> *</span></label>
				<span class="col-lg-10 pull-right">
					<input ng-model="name"
				    	name="name"
				    	maxlength="50"
				    	ng-required=true
				    	ng-minlength=5
				    	ng-maxlength=50
				    	class="form-control"
				    	required
			       	/>
			       	<span class="error" ng-show="add_army_list.name.$error.minlength">Your name must be longer than 5 characters</span>
			       	<span class="error" ng-show="add_army_list.name.$error.maxlength">Your name cannot be longer than 50 characters</span>
				</span>
			</span>
			<span class="form-group required">
				<label for="descr" class="col-lg-2 control-label text-right">Description<span class="error" ng-show="add_army_list.descr.$error.required"> *</span></label>
				<span class="col-lg-10 pull-right">
					<textarea ng-model="descr"
				       	name="descr"
				       	required
				       	ng-required=true
						class="form-control"
					></textarea>

				</span>
			</span>
			<span class="form-group required">
				<label for="points_limit" class="col-lg-2 control-label text-right">Points Limit<span class="error" ng-show="add_army_list.points_limit.$error.required"> *</span></label>
				<span class="col-lg-10 pull-right">
					<input ng-model="points_limit"
				    	name="points_limit"
				    	type="number"
				    	maxlength="11"
				  		ng-minlength=3
				  		ng-maxlength=11
				    	ng-required=true
						class="form-control"
				    	required
			       	/>
			       	<span class="error" ng-show="add_army_list.points_limit.$error.minlength">Your name must be longer than 3 characters</span>
			       	<span class="error" ng-show="add_army_list.points_limit.$error.maxlength">Your name cannot be longer than 11 characters</span>
				</span>
			</span>
			<span class="form-group">
				<label for="hide" class="col-lg-2 control-label text-right">Hidden</label>
				<span class="col-lg-1 pull-left">
					<input type="checkbox"
			       	ng-model="hide"
			       	name="hide"
			       	ng-true-value="1"
			       	ng-false-value="0"
					class="form-control"
			    />
				</span>
			</span>
			<span class="form-group">
				<span class="col-lg-offset-2 col-lg-10">
					<input class="btn btn-primary" type="submit" value="Save"/>
				</span>
			</span>
	</form>
</section>