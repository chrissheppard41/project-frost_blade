myApp.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: 'pages/partials/index', controller: "DisplayCtrl"}).
      when('/add', {templateUrl: 'pages/partials/add_army', controller: "AddCtrl"}).
      when('/view/:id', {templateUrl: 'pages/partials/view_army', controller: "ViewCtrl"}).
      when('/edit/:id', {templateUrl: 'pages/partials/edit_army', controller: "EditCtrl"}).
      when('/setup/:id', {templateUrl: 'pages/partials/setup_army', controller: "SetupCtrl"}).
      when('/user/login', {templateUrl: 'pages/partials/user_login', controller: "UserCtrl"}).
      when('/user/register', {templateUrl: 'pages/partials/user_register', controller: "UserCtrl"}).
      when('/user/confirm_register', {templateUrl: 'pages/partials/user_register_post', controller: "UserCtrl"}).
      when('/user/reset_password', {templateUrl: 'pages/partials/user_reset_password', controller: "UserCtrl"}).
      when('/user/lost_password_update', {templateUrl: 'pages/partials/user_lost_password_update', controller: "UserCtrl"}).
      when('/user/profile', {templateUrl: 'pages/partials/user_profile', controller: "UserCtrl"}).
      otherwise({redirectTo: '/'});
}]);