angular.module('RestaurantPosWeb').factory 'TablesService', ($resource, $http) ->
  class TablesService
    constructor: ->
      @url = "v1/tables/:id" unless @url

      @service = $resource("#{config.api_url}#{@url}", {}, {
       'update': { method: 'PUT'}
      })

    create: (complete) ->
      new @service().$save @onServerResponse(complete), @errorHandler

    update: (table, complete) ->
      new @service(table: table.attributes()).$update { id: table.id }, @onServerResponse(complete), @errorHandler

    delete: (table, complete) ->
      new @service().$delete {id: table.id}, @onServerResponse(complete), @errorHandler

    index: (complete) ->
      new @service().$get (data) ->
        complete data if complete

    get: (table_id, complete) ->
      new @service().$get id: table_id, @onServerResponse complete

    onServerResponse: (complete) ->
      (response) ->
        if complete
          complete response
