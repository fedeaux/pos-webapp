class TableConsumptionController
  constructor: (@scope, @state, @Payment, @Consumption, @ConsumptionsService) ->
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
    console.log @table.state, (@table.state == 'available')
    if @table.state == 'available'
      @clearConsumption()
    else
      @consumptions_service.fromTable @table, @setConsumption

  clearConsumption: ->
    @consumption = null
    @products = []
    @payment = []

  setConsumption: (response) =>
    @consumption = new @Consumption response.consumption
    @products = response.consumption.products
    @payments = response.consumption.payments

    @products.sort (p1, p2) ->
      n1 = p1.name.toLowerCase()
      n2 = p2.name.toLowerCase()
      if n1 < n2
        -1
      else if n1 > n2
        1
      else
        0

  addProduct: (product) ->
    @consumptions_service.addProduct @table, product, @setConsumption

  saveFormPayment: ->
    @consumptions_service.addPayment @table, @form_payment, @setConsumption
    @form_payment = null

  removeProduct: (product) ->
    @consumptions_service.removeProduct @table, product, @setConsumption

  removePayment: (payment) ->
    @consumptions_service.removePayment @table, payment, @setConsumption

  setPaymentForm: =>
    @form_payment = new @Payment

  clearPaymentForm: =>
    @form_payment = null

TableConsumptionController.$inject = ['$scope', '$state', 'Payment', 'Consumption', 'ConsumptionsService']
angular.module('RestaurantPosWeb').controller 'TableConsumptionController', TableConsumptionController
