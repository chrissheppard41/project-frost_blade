myApp.controller('UserCtrl', ["$scope", "$routeParams", "$rootScope", "$location", "list", "displayErrors", function($scope, $routeParams, $rootScope, $location, list, displayErrors) {
	//$scope.user_id = $sid;
	$scope.formMessage = "";



	if((($location.path() === "/user/login" || $location.path() === "/user/register") && $rootScope.logged_in) || (($location.path() === "/user/profile" && !$rootScope.logged_in))) {
		window.location.href = "#/";
	}

	$scope.login = function() {
		if ($scope.UserLoginForm.$invalid) {
			$scope.formMessage = "Form contains errors";
		} else {
			$scope.formMessage = "";
			var promise_user = list.getAsync('POST', '/user/login.json', {"data":{"Users":{"email":this.email,"password":this.password}}});

			promise_user.then(function( data ) {
				if(data.code === 200) {
					//set a global username and user_id
					$rootScope.user_id = parseInt(data.data.user_id, 0);
					$rootScope.user_name = data.data.username;
					$rootScope.logged_in = true;

					$location.path('#/');
				} else {
					$scope.formMessage = displayErrors.formErrors(data.errors);
				}
			});
		}
	};

	$scope.register = function() {
		if ($scope.UserRegisterForm.$invalid) {
			$scope.formMessage = "Form contains errors";
		} else {
			$scope.formMessage = "";
			var promise_user = list.getAsync('POST', '/user/register.json', {"data":{"Users":{"username":this.username,"email":this.email,"password":this.password,"confirm_password":this.confirm_password,"slug":""}}});

			promise_user.then(function( data ) {
				if(data.code === 200) {
					window.location.href = "#/user/confirm_register";
				} else {
					$scope.formMessage = displayErrors.formErrors(data.errors);
				}
			});
		}
	};

	$scope.lostpassword = function() {
		if ($scope.UserLostPasswordForm.$invalid) {
			$scope.formMessage = "Form contains errors";
		} else {
			$scope.formMessage = "";
			var promise_user = list.getAsync('POST', '/user/lost_password.json', {"data":{"Users":{"email":this.email}}});

			promise_user.then(function( data ) {
				if(data.code === 200) {
					window.location.href = "#/user/lost_password_update";
				} else {
					$scope.formMessage = displayErrors.formErrors(data.errors);
				}
			});
		}
	};

	if($location.path() === "/user/profile") {
		$scope.formMessage = "";
		$scope.formSuccessMessage = "";
		var promise_profile = list.getAsync('GET', '/user/profile.json', {});

		promise_profile.then(function( data ) {
			$scope.email = data.Users.email;
		});
	}
	$scope.profile = function() {
		if ($scope.UserProfileForm.$invalid) {
			$scope.formMessage = "Form contains errors";
		} else {
			$scope.formMessage = "";
			var user = {};

			if(this.password !== null && this.password !== undefined && this.password !== "") {
				user = {
					"email":this.email,
					"password": this.password,
					"confirm_password": this.confirm_password
				};
			} else {
				user = {
					"email":this.email
				};
			}


			var promise_user = list.getAsync('POST', '/user/profile.json', {"data":{"Users":user}});

			promise_user.then(function( data ) {
				if(data.code === 200) {
					$scope.formSuccessMessage = "Success: Your profile has been updated";
				} else {
					$scope.formMessage = displayErrors.formErrors(data.errors);
				}
			});
		}
	};
}]);