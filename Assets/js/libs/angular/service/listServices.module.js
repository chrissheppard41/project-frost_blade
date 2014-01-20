angular.module('listServices', []).
    factory('list', function($http, $q){
        var sharedService = {};
        sharedService.getAsync = function ($method, $url, $params) {
            sharedService.data = {};

            var deferred = $q.defer();

            if($method == "POST" || $method == "PUT") {
                $http({method: $method, url: $url, data: $params}).
                    success(function(data, status, headers, config) {
                        console.log($method, $url, data);
                        sharedService.data = data.response;
                        deferred.resolve( sharedService.data );
                    }).
                    error(function(data, status, headers, config) {
                        console.log("Service list: "+$url+" error");
                    });
            } else if($method == "DELETE") {
                $http({method: $method, url: $url, data: $params}).
                    success(function(data, status, headers, config) {
                        console.log($method, $url, data);
                        sharedService.data = data.response;
                        deferred.resolve( sharedService.data );
                    }).
                    error(function(data, status, headers, config) {
                        console.log("Service list: "+$url+" error");
                    });
            } else {
                $http({method: $method, url: $url, params: $params}).
                    success(function(data, status, headers, config) {
                        console.log($method, $url, data);
                        sharedService.data = data.response.data;
                        deferred.resolve( sharedService.data );
                    }).
                    error(function(data, status, headers, config) {
                        console.log("Service list: "+$url+" error");
                    });
            }


            return deferred.promise;
        };
        sharedService.getSecure = function ($method, $url, $params) {
            var self = this;

            var deferred = $q.defer();

            var promise_access = this.getAsync('GET', '/access.json', {});

            promise_access.then(function( data ){
                $params = $.extend({}, $params, {'access': data});

                var promise_results = self.getAsync($method, $url, $params);

                promise_results.then(function( innerdata ){
                    self.data = innerdata;

                    deferred.resolve(self.data);
                });

            });

            return deferred.promise;
        };

        return sharedService;

      });