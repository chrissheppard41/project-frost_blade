<section class="clearfix">
	<article>
		<h2>Add <span><a href="javascript:history.go(-1)" class="back">Back</a></span></h2>

		<div class="alert alert-danger alert-dismissable form" ng-show="formMessage"><span ng-bind-html="formMessage"></span></div>

		<form ng-submit="submit_add()" class="form-horizontal" name="add_army_list" id="ArmyList#Form" method="POST" accept-charset="utf-8">
			<p class="add_step_1">
				<span class="form-group required">
					<label for="name" class="col-lg-2 control-label text-right">Race</label>
					<select ng-model="race" ng-change="dis_races()" name="data[ArmyLists][races_id]" class="form-control">
						<option ng-repeat="type in Races.races" value="{{$index}}">{{type.name}}</option>
					</select>
				</span>
			</p>



			<p class="add_step_2" ng-hide="step_2_view">
				<span class="form-group required">
					<label for="name" class="col-lg-2 control-label text-right">Army</label>
					<select ng-model="army" ng-change="dis_squads()" name="data[ArmyLists][armies_id]" class="form-control">
						<option ng-repeat="army in armies" value="{{army.id}}">{{army.name}}</option>
					</select>
				</span>
			</p>
			<h3 class="add_step_3" ng-hide="step_3_view">Available units</h3>
			<ul class="add_step_3" ng-hide="step_3_view">
				<li ng-repeat="squad in squads" id="{{squad.id}}">{{squad.type_name}} - {{squad.name}}</li>
			</ul>
			<p class="add_step_4" ng-hide="step_3_view">
				<span class="form-group required">
					<label for="name" class="control-label">Name<span class="error" ng-show="add_army_list.name.$error.required"> *</span></label>
					<input ng-model="name"
						name="name"
						maxlength="50"
						ng-required=true
						ng-minlength=5
						ng-maxlength=50
						class="form-control"
						type="text"
						required
					/>
					<span class="error" ng-show="add_army_list.name.$error.minlength">Your name must be longer than 5 characters</span>
					<span class="error" ng-show="add_army_list.name.$error.maxlength">Your name cannot be longer than 50 characters</span>
				</span>
				<span class="form-group required">
					<label for="descr" class="col-lg-2 control-label text-right">Description<span class="error" ng-show="add_army_list.descr.$error.required"> *</span></label>
					<textarea ng-model="descr"
						name="descr"
						required
						ng-required=true
						class="form-control"
					></textarea>
				</span>
				<span class="form-group required">
					<label for="points_limit" class="col-lg-2 control-label text-right">Points Limit<span class="error" ng-show="add_army_list.points_limit.$error.required"> *</span></label>
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

				<span class="checkbox">
					<span for="hide__" class="label">Hidden</span>
					<input type="checkbox" ng-model="hide" id="squaredFour" name="hide" ng-true-value="1" ng-false-value="0" />
					<label for="squaredFour"></label>
				</span>

				<span class="form-group">
					<button class="btn btn-primary">Save</button>
				</span>
			</p>
		</form>
	</article>
</section>