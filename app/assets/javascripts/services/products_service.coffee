angular.module('RestaurantPosWeb').factory 'ProductsService', ($resource, $http, ResourceService) ->
  class ProductsService extends ResourceService
    constructor: ->
      super @errorHandler, 'product', 'products', 'v1/products/:id'
