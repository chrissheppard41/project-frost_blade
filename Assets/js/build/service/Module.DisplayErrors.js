myApp.factory('displayErrors', [function(){
	return {
		formErrors: function(arr) {
			var output = "";

			if(arr.message === undefined) {
				for(var i = 0, l = arr.length; i < l; i++) {
					if(i !== 0) output += "<br />";
					output += "<strong>"+arr[i][0]+"</strong>: "+arr[i][1];

				}
			} else {
				output = "<strong>Problem</strong>: Sorry there is a problem creating your account, please try back later.";
			}

			return output;
		}
	};
}]);