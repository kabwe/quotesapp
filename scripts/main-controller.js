angular.module('quoteApp',[]);
angular.module('quoteApp').controller('quoterequest',quoterequest);
//core function
function quoterequest($scope, $http,$window) {
	
	$http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded;charset=utf-8";
	//$scope.error_response="";
	//$scope.createDetails = false;
	//$scope.createSuccess = false;
	//////
	$scope.request_quote = {
			vehicle_year : "",
			vehicle_make : "",
			vehicle_model: "",
			vehicle_description: "",
			driver_type: "",
			cover_type: "",
			fullname: "",
			email: "",
			id: "",
			mobile: "",
            license_type: "" 
			}
	$scope.postRequest = function(details){
		    console.log(details);

			var request = $.param({
						"year" :details.vehicle_year,
						"model" : details.vehicle_model,
						"description" : details.vehicle_description,
						"make" : details.vehicle_make,
						"cover" : details.cover_type,
						"fullname": details.fullname,
						"email": details.email,
						"id": details.id,
						"mobile": details.mobile,
						"license_type":details.license_type,
						"driver_type" : "regular"
					});
			var url ="api/quotation/requests/add";
	
			
			$http.post(url, request)
			.success(function (data, status, headers, config) {
				alert(''+ data);
				console.log(data);
		
			})
			.error(function (data, status, headers, config) {
				console.log(data);
			}); 
	}
	//
}
