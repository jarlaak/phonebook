var phonebook = angular.module("phonebook",[]);

phonebook.controller('phonebookCtrl',phonebookCtrl);

function phonebookCtrl($scope,$http) {
    function updateView(){
	$http.get("phonebook/person/search/").then(function(response) {
            $scope.searchResults = response.data;
	});
    }
    updateView();
    $scope.searchCriteria = "";
    $scope.update = function(searchCriteria) {
	$http.get("phonebook/person/search/"+encodeURIComponent(searchCriteria)).then(function(response) {
            $scope.searchResults = response.data;
	    document.getElementById("searchinput").style.color="black";
	},function(response){
	    document.getElementById("searchinput").style.color="red";
	});
    };

    $scope.addperson = function () {
	$scope.person={};
	$scope.person.firstname="";
	$scope.person.lastname="";
	$scope.person.phonenumber=[];
	$scope.openperson();
    }

    $scope.addphonenumberline = function(){
	$scope.person.phonenumber.push("");
    }

    $scope.closeperson = function() {
	    document.getElementById("addpersoncontainer").style.display="none";
    }

    $scope.openperson = function() {
	    document.getElementById("addpersoncontainer").style.display="inline";
    }

    
    $scope.submitperson = function(person){
	document.getElementById("addpersoncontainer").style.display="none";
	$http.post("phonebook/person/",person).then(function(response) {
            $scope.searchResults = response.data;
	    $scope.closeperson();
	    updateView();
	},function(response){
	});
    }
};
