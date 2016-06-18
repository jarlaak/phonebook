var phonebook = angular.module("phonebook",[]);

phonebook.controller('phonebookCtrl',phonebookCtrl);

function phonebookCtrl($scope,$http) {
    console.log("kjhfskdjfhsjdkhfjsd");
    $http.get("phonebook/person/search/").then(function(response) {
        $scope.searchResults = response.data;
	console.log("search " + response.data);
    });
    $scope.searchCriteria = "";
    $scope.update = function(searchCriteria) {
	$http.get("phonebook/person/search/"+encodeURIComponent(searchCriteria)).then(function(response) {
            $scope.searchResults = response.data;
	    document.getElementById("searchinput").style.color="black";
	    console.log("search " + response.data);
	},function(response){
	    document.getElementById("searchinput").style.color="red";
	    console.log('does not find');
});
    };
};
