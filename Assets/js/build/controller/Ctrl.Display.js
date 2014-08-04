myApp.controller('DisplayCtrl', ["$scope", "$http", "list", "$rootScope", "$location", "vote", function($scope, $http, list, $rootScope, $location, vote) {
	//$scope.user_id = $sid;

	var promise_all = list.getAsync('GET', '/armies_all.json', {});
	$scope.my_armies = {};
	$scope.all_armies = {};
	$scope.top_armies = {};

	promise_all.then(function( data ) {

		if($rootScope.user_id !== 0) {
			$scope.my_armies = list.data.private.ArmyLists;
			$scope.my_armies_count = list.data.private.count;
		}

		$scope.all_armies = list.data.public.ArmyLists;
		$scope.all_armies_count = list.data.public.count;

		$scope.top_armies = list.data.top.ArmyLists;
	});

	$scope.votes = function(id, type) {
		vote.votingFront($scope, id, type);
	};

	$scope.view = function(code) {
		window.location.href = "#/view/"+code;
	};

	$scope.dateMomment = function(value) {
		return moment(value, 'YYYY-MM-DD HH:mm:ss').fromNow();
	};

	$scope.submit_delete = function(id) {

		var promise_delete = list.getAsync('DELETE', '/delete_army/'+id+'.json', {});

		promise_delete.then(function( data ) {

			if(list.data.code == 200) {
				var promise_all = list.getAsync('GET', '/armies_all.json', {});
				$scope.my_armies = {};
				$scope.all_armies = {};
				$scope.top_armies = {};

				promise_all.then(function( data ) {

					if($rootScope.user_id !== 0) {
						$scope.my_armies = list.data.private.ArmyLists;
						$scope.my_armies_count = list.data.private.count;
					}

					$scope.all_armies = list.data.public.ArmyLists;
					$scope.all_armies_count = list.data.public.count;

					$scope.top_armies = list.data.top.ArmyLists;
				});
			} else {
				//error here
				//$scope.message = list.errors;
			}
		});

		return false;
	};
}]);