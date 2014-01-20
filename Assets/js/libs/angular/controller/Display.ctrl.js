function DisplayCtrl($scope, $http, list, $rootScope) {
	$scope.user_id = $sid;

	var promise_my = list.getAsync('GET', '/armies.json', {});
	$scope.my_armies = {};

	promise_my.then(function( data ){
		$scope.my_armies = list.data;
	});

	var promise_all = list.getAsync('GET', '/publicarmies.json', {});
	$scope.all_armies = {};

	promise_all.then(function( data ){
		$scope.all_armies = list.data;
	});

	$scope.dateMomment = function(value) {
		return moment(value, 'YYYY-MM-DD HH:mm:ss').fromNow();
	};

	$scope.submit_delete = function(id) {

		var promise_delete = list.getAsync('DELETE', '/delete_army/'+id+'.json', {});

		promise_delete.then(function( data ) {

			if(list.data.code == 200) {
				var promise_my = list.getAsync('GET', '/armies.json', {});
				$scope.my_armies = {};

				promise_my.then(function( data ){console.log(data);
					$scope.my_armies = list.data;
				});
			} else {
				//error here
				//$scope.message = list.errors;
			}
		});

		return false;
	};


}