angular.module('RestaurantPosWeb').factory 'ProductCategoriesService', ($resource, $http, ResourceService) ->
  class ProductCategoriesService extends ResourceService
    constructor: ->
      super @errorHandler, 'product_category', 'product_categories', 'v1/product_categories'
