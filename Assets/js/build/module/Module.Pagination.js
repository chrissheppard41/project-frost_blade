var Pagination = (function(){
	return {
		set: function($scope, page) {
			$scope.currentPage = page;
			var min = ($scope.numPerPage * $scope.currentPage);
			var max = ($scope.numPerPage * $scope.currentPage) + $scope.numPerPage;

			$scope.armies = $scope.public_armies.slice(min, max);
		}
	};
})();