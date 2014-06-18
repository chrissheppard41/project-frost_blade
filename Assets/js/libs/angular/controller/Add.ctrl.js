function AddCtrl($scope, $routeParams, $location, list) {
	$scope.user_id = $sid;

	console.log("Add");

	$scope.step_2_view = true;
	$scope.step_3_view = true;
	$scope.step_4_view = true;

	var promise_types = list.getAsync('GET', '/armytypes.json', {});

	$scope.my_armies = {};

	promise_types.then(function( data ) {
		$scope.Races = list.data;
	});


	$scope.dis_races = function() {
		$scope.armies = $scope.Races.Races[$scope.race].Armies;
		$scope.step_2_view = false;
	};

	$scope.dis_squads = function() {
		//var promise_squads = list.getAsync('GET', '/squads/'+$scope.race+'.json', {});
		var promise_squads = list.getSecure('GET', '/squads/'+$scope.army+'', {});
		$scope.squads = {};

		promise_squads.then(function( data ){
			$scope.squads = data.Squads;
			$scope.step_3_view = false;
		});
	};

	$scope.displayFormmessages = function(response) {
		$scope.formMessage = "";
		$scope.formMessage = list.outputError(response.errors);
	};

	$scope.add_resets = function() {
		$scope.add_army_list.$dirty = false;
        $scope.add_army_list.$pristine = true;

		//resets for this forum
		$scope.army = {};
		$scope.race = {};
		$scope.races_id = '';
		$scope.name = '';
		$scope.descr = '';
		$scope.points_limit = '';
		$scope.hide = '';
		$scope.users_id = '';

		//resets for view
		$scope.step_2_view = true;
		$scope.step_3_view = true;
		$scope.step_4_view = true;

		$scope.sec_add_army = false;
	};
	$scope.submit_add = function() {
		if ($scope.add_army_list.$invalid) {
			$scope.formMessage = "Form contains errors";
		} else {
			$scope.formMessage = "";

			if(this.hide == undefined) this.hide = 0;

			var promise_post = list.getAsync('POST', '/add/save.json', {'ArmyLists':{'armies_id':this.army, 'name':this.name, 'descr':this.descr, 'point_limit':this.points_limit, 'hide':this.hide}});

			promise_post.then(function( data ){
				if(data.code == 200) {

					$scope.add_resets();

					$location.path('#/');
				} else {
					$scope.displayFormmessages(data);
				}
			});
		}
		return false;
	};
}