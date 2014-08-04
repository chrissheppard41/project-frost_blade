myApp.controller('UserManageCtrl', ["$scope", "$rootScope", "$location", function($scope, $rootScope, $location) {

	$rootScope.user_id = $sid;
	$rootScope.user_name = $suser;

	if(!isNaN($rootScope.user_id) && $rootScope.user_name != "Guest") {
		$rootScope.logged_in = true;
	} else {
		$rootScope.logged_in = false;
	}

}]);
