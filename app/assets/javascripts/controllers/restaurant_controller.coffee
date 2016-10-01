class RestaurantController
  constructor: (@scope, @state, @Restaurant, @Product, @RestaurantService, @ProductsService) ->
    @service = new @RestaurantService
    @products_service = new @ProductsService

    @loadRestaurant()
    @products_service.index @productsServiceIndexCallback

  productsServiceIndexCallback: (response) =>
    @setProducts ( new @Product(product) for product in response.products )

  setProducts: (products) ->
    @products = products

  loadRestaurant: ->
    @service.index @setRestaurant

  setRestaurant: (response) =>
    @restaurant = new @Restaurant response.restaurant

  save: =>
    @service.update @restaurant, @setRestaurant

RestaurantController.$inject = ['$scope', '$state', 'Restaurant', 'Product', 'RestaurantService', 'ProductsService']
angular.module('RestaurantPosWeb').controller 'RestaurantController', RestaurantController
