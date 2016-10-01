class TableConsumptionController
  constructor: (@scope, @state, @filter, @Payment, @Consumption, @ConsumptionsService) ->
    window.ctrl = @
    @scope.$on 'TablesController::TableSelected', @tableSelected
    @scope.$on 'TablesController::TableOccupied', @loadConsumption
    @consumptions_service = new @ConsumptionsService
    @view_state = 'consumption'

  tableSelected: (event, data) =>
    unless @table and @table.id == data.table.id
      @table = data.table
      @loadConsumption()

  loadConsumption: =>
    @consumption = null
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

  saveFormPayment: (form) ->
    if form.$valid
      @consumptions_service.addPayment @table, @form_payment, @setConsumption
      @form_payment = null

  removeProduct: (product) ->
    @consumptions_service.removeProduct @table, product, @setConsumption

  removePayment: (payment) ->
    @consumptions_service.removePayment @table, payment, @setConsumption

  setPaymentForm: =>
    @form_payment = new @Payment

  clearFormPayment: ->
    @form_payment = null

  update: ->
    @consumptions_service.update @table, @consumption, @setConsumption

  finish: ->
    if @consumption.expected_discount > 0
      formatted = @filter('currency') @consumption.expected_discount

      unless confirm("The payment is below the total cost by #{formatted}, do you want to consider it a discount?")
        return

    @consumption.state = 'payed'
    @update()

TableConsumptionController.$inject = ['$scope', '$state', '$filter', 'Payment', 'Consumption', 'ConsumptionsService']
angular.module('RestaurantPosWeb').controller 'TableConsumptionController', TableConsumptionController
