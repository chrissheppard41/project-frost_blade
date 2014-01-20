angular.module('route_helper', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: 'partials/index', controller: DisplayCtrl}).
      when('/add', {templateUrl: 'partials/add_army', controller: AddCtrl}).
      when('/view/:id', {templateUrl: 'partials/view_army', controller: ViewCtrl}).
      when('/edit/:id', {templateUrl: 'partials/edit_army', controller: EditCtrl}).
      when('/setup/:id', {templateUrl: 'partials/setup_army', controller: SetupCtrl}).
      otherwise({redirectTo: '/'});
}]);