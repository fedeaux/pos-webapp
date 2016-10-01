angular.module('RestaurantPosWeb').factory 'ConsumptionsService', ($resource, $http, ResourceService) ->
  class ConsumptionsService extends ResourceService
    constructor: ->
      super @errorHandler, 'consumption', 'consumptions', '/v1/tables/:table_id/consumption/:action'

    fromTable: (table, complete) ->
      new @service().$get table_id: table.id, @onServerResponse complete

    addProduct: (table, product, complete) ->
      @actionOnProduct table, product, 'add_product', complete

    removeProduct: (table, product, complete) ->
      @actionOnProduct table, product, 'remove_product', complete

    actionOnProduct: (table, product, action, complete) ->
      new @service(consumption: { product_id: product.id }).$update { table_id: table.id, action: action },
        @onServerResponse(complete), @errorHandler
