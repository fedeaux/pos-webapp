angular.module('RestaurantPosWeb').factory 'ReportsService', ($resource, $http, ResourceService) ->
  class ReportsService extends ResourceService
    constructor: ->
      super @errorHandler, 'report', 'reports', 'v1/reports/:id'
