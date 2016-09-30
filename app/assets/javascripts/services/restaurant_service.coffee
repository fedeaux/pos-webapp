angular.module('RestaurantPosWeb').factory 'RestaurantService', ($resource, $http) ->
  class RestaurantService
    constructor: ->
      @url = "v1/restaurant"

      @service = $resource("#{config.api_url}#{@url}", {}, {
       'update': { method: 'PUT'}
      })

    update: (restaurant, complete) ->
      new @service(restaurant: restaurant.attributes()).$update {}, @onServerResponse(complete), @errorHandler

    index: (complete) ->
      new @service().$get (data) ->
        complete data if complete

    onServerResponse: (complete) ->
      (response) ->
        if complete
          complete response

    errorHandler: (error) ->
      console.log error
