'use strict';

angular.module('angApp', [])
.config(function() {

})
.controller('MainCtrl', ['$scope', function ($scope) {
    $scope.message = 'You have arrived!'
}]);