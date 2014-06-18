<section class="clearfix">
	<h2>Edit</h2>
	<a href="#/" class="btn btn-danger">back</a>
	<div class="error">{{formMessage}}</div>

	<form ng-submit="submit_edit()" class="form-horizontal" name="edit_army_list" id="ArmyList#Form" method="POST" accept-charset="utf-8">
		<span class="form-group required">
			<label for="name" class="col-lg-2 control-label text-right">Name<span class="error" ng-show="edit_army_list.name.$error.required"> *</span></label>
			<span class="col-lg-10 pull-right">
				<input ng-model="name"
			    	name="name"
			    	maxlength="50"
			    	ng-required=true
			    	ng-minlength=5
			    	ng-maxlength=50
			    	class="form-control"
			    	value="{{name}}"
			    	required
		       	/>
		       	<span class="error" ng-show="edit_army_list.name.$error.minlength">Your name must be longer than 5 characters</span>
		       	<span class="error" ng-show="edit_army_list.name.$error.maxlength">Your name cannot be longer than 50 characters</span>
			</span>
		</span>
		<span class="form-group required">
			<label for="descr" class="col-lg-2 control-label text-right">Description<span class="error" ng-show="edit_army_list.descr.$error.required"> *</span></label>
			<span class="col-lg-10 pull-right">
				<textarea ng-model="descr"
			       	name="descr"
			       	required
			       	ng-required=true
					class="form-control"
				>{{descr}}</textarea>

			</span>
		</span>
		<span class="form-group required">
			<label for="points_limit" class="col-lg-2 control-label text-right">Points Limit<span class="error" ng-show="edit_army_list.points_limit.$error.required"> *</span></label>
			<span class="col-lg-10 pull-right">
				<input ng-model="points_limit"
			    	name="points_limit"
			    	type="number"
			    	maxlength="11"
			  		ng-minlength=3
			  		ng-maxlength=11
			    	ng-required=true
					class="form-control"
			    	value="{{points_limit}}"
			    	required
		       	/>
		       	<span class="error" ng-show="edit_army_list.points_limit.$error.minlength">Your name must be longer than 3 characters</span>
		       	<span class="error" ng-show="edit_army_list.points_limit.$error.maxlength">Your name cannot be longer than 11 characters</span>
		       	<span class="error" ng-show="edit_army_list.points_limit.$error.number">Must contain numbers</span>
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