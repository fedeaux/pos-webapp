class RestaurantController
  constructor: (@scope, @state, @Restaurant, @Product, @Waiter,
      @RestaurantService, @ProductsService, @WaitersService) ->

    @service = new @RestaurantService
    @products_service = new @ProductsService
    @waiters_service = new @WaitersService

    @loadRestaurant()
    @products_service.index @productsServiceIndexCallback
    @waiters_service.index @waitersServiceIndexCallback

  productsServiceIndexCallback: (response) =>
    @setProducts ( new @Product(product) for product in response.products )

  waitersServiceIndexCallback: (response) =>
    @setWaiters ( new @Waiter(waiter) for waiter in response.waiters )

  setProducts: (products) ->
    @products = products

  setWaiters: (waiters) ->
    @waiters = waiters

  loadRestaurant: ->
    @service.index @setRestaurant

  setRestaurant: (response) =>
    @restaurant = new @Restaurant response.restaurant

  save: =>
    @service.update @restaurant, @setRestaurant

RestaurantController.$inject = ['$scope', '$state', 'Restaurant', 'Product', 'Waiter'
                                'RestaurantService', 'ProductsService', 'WaitersService']
angular.module('RestaurantPosWeb').controller 'RestaurantController', RestaurantController
