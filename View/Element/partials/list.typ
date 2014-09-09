<section class="clearfix">
	<article>
		<h2>Public army setups <small> - {{armyTotal}} set ups</small> <span><a href="#/add" class="add" ng-show="logged_in">Add</a></span><span><a href="javascript:history.go(-1)" class="back">Back</a></span></h2>
		<p class="header">
			<span><a href="" title="Order by score" ng-click="predicate = 'score'; reverse=!reverse;">&nbsp;</a></span>
			<span>Name <a href="" title="Order by name" ng-click="predicate = 'name'; reverse=!reverse;">&nbsp;</a></span>
			<span>Description</span>
			<span>Points <a href="" title="Order by points" ng-click="predicate = 'point_limit'; reverse=!reverse;">&nbsp;</a></span>
		</p>
		<p class="search">Search: <input type="text" ng-model="searchText" name="searchText" id="input" /></p>
		<ul class='army_lists'>
			<li ng-repeat="army in armies | filter:searchText | orderBy:predicate:reverse" id="myarmy_{{army.code}}">
				<div>
					<a href="" class="blue{{army.vote | active:'up'}}" ng-click="votes(army.code, 'up')"><i>&nbsp;</i></a>
					<a href="" class="red{{army.vote | active:'down'}}" ng-click="votes(army.code, 'down')"><i>&nbsp;</i></a>
				</div>
				<div>
					<span class="army {{army.colours_name}}"><i class="icon_{{army.icon}}">&nbsp;</i></span>
					<span class="count">{{army.score}}</span>
				</div>
				<a href="#/view/{{army.code}}">
					<h3 class="pointer">
						<i ng-show="army.hide" class="padlock">&nbsp;</i> {{army.name}}
						<small>By {{army.username}}, Modified: {{army.modified | date}}</small>
					</h3>
					<em>
						{{army.descr | truncate:250}}
					</em>
					<var>
						{{army.point_limit}}<br />pts
					</var>
				</a>
			</li>
		</ul>
		<p class="pagination">
			<span ng-hide="pagecount == 0">
				<a href ng-click="startPage()" class="{disabled: currentPage == 0}">&lt;&lt;</a>
				<a href ng-click="prevPage()" class="{disabled: currentPage == 0}">&lt;</a>
				<a href ng-click="setPage(n)" ng-repeat="n in [] | range:pagecount:currentPage" ng-class="{active: n == currentPage}">{{n}} </a>
				<a href ng-click="nextPage()" class="{disabled: currentPage == pagecount}">&gt;</a>
				<a href ng-click="lastPage()" class="{disabled: currentPage == pagecount}">&gt;&gt;</a>
			</span>
		</p>
	</article>
</section>