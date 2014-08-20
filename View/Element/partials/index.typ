<section class="clearfix">
	<a href="#/add" class="btn btn-success">Add</a>

	<article class="width_50 float first">
		<h2>Public army setups <span>{{all_armies_count}} set ups</span></h2>
		<ul class='army_display'>
			<li ng-repeat="army in all_armies">
				<div>
					<a href="" class="blue{{army.vote | active:'up'}}" ng-click="votes(army.code, 'up')"><i>&nbsp;</i></a>
					<a href="" class="red{{army.vote | active:'down'}}" ng-click="votes(army.code, 'down')"><i>&nbsp;</i></a>
				</div>
				<div>
					<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
					<span class="count">{{army.score}}</span>
				</div>
				<a href="#/view/{{army.code}}" class="half">
					<h3>
						{{army.name}}
						<small>By {{army.username}}, Modified {{army.modified | date}}</small>
					</h3>
					<var>
						{{army.point_limit}}<br />pts
					</var>
				</a>
			</li>
		</ul>
	</article>
	<article class="width_50 float">
		<h2>Top army setups</h2>
		<ul class='army_display'>
			<li ng-repeat="army in top_armies">
				<div>
					<a href="" class="blue{{army.vote | active:'up'}}" ng-click="votes(army.code, 'up')"><i>&nbsp;</i></a>
					<a href="" class="red{{army.vote | active:'down'}}" ng-click="votes(army.code, 'down')"><i>&nbsp;</i></a>
				</div>
				<div>
					<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
					<span class="count">{{army.score}}</span>
				</div>
				<a href="#/view/{{army.code}}" class="half">
					<h3>
						{{army.name}}
						<small>By {{army.username}}, Modified {{army.modified | date}}</small>
					</h3>
					<var>
						{{army.point_limit}}<br />pts
					</var>
				</a>
			</li>
		</ul>
	</article>

	<article ng-show="logged_in">
		<h2>My army setups <span><em>{{my_armies_count}} set ups </em><a href="#/add" class="add">Add</a> <a href="#/my_lists" class="yellow">My setups</a></span></h2>
		<ul class='army_display'>
			<li ng-repeat="army in my_armies" id="myarmy_{{army.id}}">
				<div>
					<a href="" class="blue{{army.vote | active:'up'}}" ng-click="votes(army.code, 'up')"><i>&nbsp;</i></a>
					<a href="" class="red{{army.vote | active:'down'}}" ng-click="votes(army.code, 'down')"><i>&nbsp;</i></a>
				</div>
				<div>
					<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
					<span class="count">{{army.score}}</span>
				</div>
				<h3>
					<i ng-show="army.hide" class="padlock">&nbsp;</i> {{army.name}}
					<small>{{army.descr | truncate:50}}</small>
				</h3>
				<var>
					{{army.point_limit}}<br />pts
				</var>
				<div>
					<span>
						Created: {{army.created | date}}
					</span>
					<span>
						Modified: {{army.modified | date}}
					</span>
				</div>
				<div>
					<a href="#/view/{{army.id}}" class="view">View</a><a href="#/edit/{{army.id}}" class="edit">Edit</a><a href="#/setup/{{army.id}}" class="setup">Setup</a><a href="#/" class="delete" ng-confirm-click="Are you sure you want to delete this army?" confirmed-click="{{army.id}}">Delete</a>
				</div>
			</li>
		</ul>
	</article>
</section>