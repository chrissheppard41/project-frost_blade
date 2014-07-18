<section class="clearfix">
	<a href="#/add" class="btn btn-success">Add</a>

	<article class="width_50 float first">
		<h2>Public army setups <span>{{all_armies_count}} set ups</span></h2>
		<ul class='army_display'>
			<li ng-repeat="army in all_armies" ng-click="view(army.code)">
				<div>
					<a href="" class="blue{{army.vote | active:'up'}}" ng-click="votes(army.code, 'up')">+</a>
					<a href="" class="red{{army.vote | active:'down'}}" ng-click="votes(army.code, 'down')">-</a>
				</div>
				<div>
					<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
					<span class="count">{{army.score}}</span>
				</div>
				<div>
					<h3>
						{{army.name}}
						<span>By Lorem Ipsum, Modified {{dateMomment(army.modified)}}</span>
					</h3>
				</div>
				<div>
					<span>
						{{army.point_limit}} pts
					</span>
				</div>
			</li>
		</ul>
	</article>
	<article class="width_50 float">
		<h2>Top army setups</h2>
		<ul class='army_display'>
			<li ng-repeat="army in top_armies">
				<div>
					<a href="" class="blue{{army.vote | active:'up'}}" ng-click="votes(army.code, 'up')">+</a>
					<a href="" class="red{{army.vote | active:'down'}}" ng-click="votes(army.code, 'down')">-</a>
				</div>
				<div>
					<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
					<span class="count">{{army.score}}</span>
				</div>
				<div>
					<h3>
						{{army.name}}
						<span>By Lorem Ipsum, Modified {{dateMomment(army.modified)}}</span>
					</h3>
				</div>
				<div>
					<span>
						{{army.point_limit}} pts
					</span>
				</div>
			</li>
		</ul>
	</article>
	<?php
	if(\Configure::Logged()) {
	?>
	<article>
		<h2>My army setups <span>{{my_armies_count}} set ups <a href="#/add" class="add">Add</a></span></h2>
		<ul class='army_display'>
			<li ng-repeat="army in my_armies" id="myarmy_{{army.id}}">
				<div>
					<a href="" class="blue{{army.vote | active:'up'}}" ng-click="votes(army.code, 'up')">+</a>
					<a href="" class="red{{army.vote | active:'down'}}" ng-click="votes(army.code, 'down')">-</a>
				</div>
				<div>
					<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
					<span class="count">{{army.score}}</span>
				</div>
				<div>
					<h3>
						<i ng-show="army.hide" class="padlock">&nbsp;</i> {{army.name}}
						<span>{{army.descr | truncate:50}}</span>
					</h3>
				</div>
				<div>
					<span>
						{{army.point_limit}} pts
					</span>
				</div>
				<div>
					<span>
						Created: A month ago
					</span>
					<span>
						Modified: 23 days ago
					</span>
				</div>
				<div>
					<a href="#/view/{{army.id}}" class="view">View</a><a href="#/edit/{{army.id}}" class="edit">Edit</a><a href="#/setup/{{army.id}}" class="setup">Setup</a><a href="#/" class="delete" ng-confirm-click="Are you sure you want to delete this army?" confirmed-click="{{army.id}}">Delete</a>
				</div>
			</li>
		<ul>
	</article>
	<?php
	}
	?>
</section>