angular.module('RestaurantPosWeb').factory 'WaitersService', ($resource, $http, ResourceService) ->
  class WaitersService extends ResourceService
    constructor: ->
      super @errorHandler, 'waiter', 'waiters', 'v1/waiters/:id'
