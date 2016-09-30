class DashboardController
  constructor: (@scope, @state) ->

DashboardController.$inject = ['$scope', '$state']
angular.module('RestaurantPosWeb').controller 'DashboardController', DashboardController
