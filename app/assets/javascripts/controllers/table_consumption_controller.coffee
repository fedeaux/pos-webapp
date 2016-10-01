class TableConsumptionController
  constructor: (@scope, @state, @ConsumptionsService) ->
    window.ctrl = @
    @scope.$on 'TablesController::TableSelected', @tableSelected
    @consumptions_service = new @ConsumptionsService
    @view_state = 'consumption'

  tableSelected: (event, data) =>
    unless @table and @table.id == data.table.id
      @table = data.table
      @loadConsumption()

  loadConsumption: ->
    @consumption = null
    @consumptions_service.fromTable @table, @setConsumption

  setConsumption: (response) =>
    @products = response.consumption.products
    @payments = response.consumption.payments

  addProduct: (product) ->
    @consumptions_service.addProduct @table, product, =>
      @products.push product
      @products.sort (p1, p2) ->
        n1 = p1.name.toLowerCase()
        n2 = p2.name.toLowerCase()
        if n1 < n2
          -1
        else if n1 > n2
          1
        else
          0

  removeProduct: (product) ->
    @consumptions_service.removeProduct @table, product, =>
      @products.splice @products.indexOf(product), 1

TableConsumptionController.$inject = ['$scope', '$state', 'ConsumptionsService']
angular.module('RestaurantPosWeb').controller 'TableConsumptionController', TableConsumptionController
