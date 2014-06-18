angular.module('route_helper', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: 'pages/partials/index', controller: DisplayCtrl}).
      when('/add', {templateUrl: 'pages/partials/add_army', controller: AddCtrl}).
      when('/view/:id', {templateUrl: 'pages/partials/view_army', controller: ViewCtrl}).
      when('/edit/:id', {templateUrl: 'pages/partials/edit_army', controller: EditCtrl}).
      when('/setup/:id', {templateUrl: 'pages/partials/setup_army', controller: SetupCtrl}).
      otherwise({redirectTo: '/'});
}]);