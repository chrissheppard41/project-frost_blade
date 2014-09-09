myApp.controller('ListCtrl', ["$scope", "$rootScope", "$routeParams", "list", "vote", function($scope, $rootScope, $routeParams, list, vote) {
	$scope.user_id = $sid;

	$scope.routeParams = $routeParams;
	console.log("List", $scope.routeParams.id);

	var url = "armies_public";
	if((window.location.href).indexOf("my_lists") > -1) {
		if(!$rootScope.logged_in) {
			window.location.href = "#/";
		}
		url = "armies_personal";
	}


	var promise_all = list.getAsync('GET', '/'+url+'.json', {});
	$scope.public_armies = [];
	$scope.armies = [];
	$scope.currentPage = 0;
	$scope.numPerPage = 10;
	$scope.maxSize = 5;
	$scope.pagecount = 0;

	promise_all.then(function( data ) {
		$scope.public_armies = list.data.ArmyLists;
		$scope.armies = $scope.public_armies.slice(0, $scope.numPerPage);

		$scope.armyTotal = $scope.public_armies.length;

		$scope.pagecount = Math.floor($scope.armyTotal/$scope.numPerPage);
	});

	$scope.votes = function(id, type) {
		vote.votingFront($scope, id, type);
	};

	$scope.prevPage = function () {
		if ($scope.currentPage > 0) {
			Pagination.set($scope, ($scope.currentPage - 1));
		}
	};

	$scope.nextPage = function () {
		if ($scope.currentPage < $scope.public_armies.length - 1) {
			Pagination.set($scope, ($scope.currentPage + 1));
		}
	};

	$scope.setPage = function(page) {
		Pagination.set($scope, page);
	};

	$scope.startPage = function() {
		Pagination.set($scope, 0);
	};

	$scope.lastPage = function() {
		Pagination.set($scope, ($scope.pagecount - 1));
	};

}]);