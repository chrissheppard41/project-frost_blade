myApp.factory('vote', ["list", function(list){
	return {
		votingFront: function($scope, id, type) {
			var promise_vote = list.getAsync('PUT', '/vote/'+id+'/'+type+'.json', {});

			promise_vote.then(function( data ) {

				if(list.data.code == 200) {
					var promise_all = list.getAsync('GET', '/armies_all.json', {});
					$scope.my_armies = {};
					$scope.all_armies = {};
					$scope.top_armies = {};

					promise_all.then(function( data ) {

						if($scope.user_id !== 0) {
							$scope.my_armies = list.data.private.armylists;
							$scope.my_armies_count = list.data.private.count;
						}

						$scope.all_armies = list.data.public.armylists;
						$scope.all_armies_count = list.data.public.count;

						$scope.top_armies = list.data.top.armylists;
					});
				} else {
					//error here
					//$scope.message = list.errors;
					if(list.data.code == 403) {
						window.location.href = '#/user/login';
					}
				}
			});
		},
		votingView: function($scope, id, type) {
			var promise_vote = list.getAsync('PUT', '/vote/'+id+'/'+type+'.json', {});

			promise_vote.then(function( data ) {

				if(list.data.code == 200) {
					var promise_my = list.getAsync('GET', '/view_army/'+$scope.routeParams.id+'.json', {});
					$scope.army = {};

					promise_my.then(function( data ){
						$scope.army = list.data.armylists;
					});
				} else {
					//error here
					//$scope.message = list.errors;
					if(list.data.code == 403) {
						window.location.href = '#/user/login';
					}
				}
			});
		}
	};
}]);