class RestaurantController
  constructor: (@scope, @state, @Restaurant, @RestaurantService) ->
    @service = new @RestaurantService
    @loadRestaurant()

  loadRestaurant: ->
    @service.index @setRestaurant

  setRestaurant: (response) =>
    @restaurant = new @Restaurant response.restaurant

  save: =>
    @service.update @restaurant, @setRestaurant

RestaurantController.$inject = ['$scope', '$state', 'Restaurant', 'RestaurantService']
angular.module('RestaurantPosWeb').controller 'RestaurantController', RestaurantController
