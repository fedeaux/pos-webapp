class WaitersController
  constructor: (@scope, @state, @Waiter, @WaitersService) ->
    window.ctrl = @
    @service = new @WaitersService
    @form_waiter = null

    @loadWaiters()

  loadWaiters: ->
    @service.index @setWaiters

  setCategories: (response) =>
    @available_categories = response.waiter_categories

  setWaiters: (response) =>
    @waiters = {}

    if response.waiters
      for waiter_attributes in response.waiters
        @setWaiter waiter_attributes

      @updateAuxiliarDataStructures()

  waiterUpdated: (response) =>
    @setWaiter response.waiter
    @clearFormWaiter()
    @updateAuxiliarDataStructures()

  setWaiter: (waiter_attributes) =>
    @waiters[waiter_attributes.id] = new @Waiter waiter_attributes

  updateAuxiliarDataStructures: =>
    @displayable_waiters = (waiter for id, waiter of @waiters)

  setFormWaiter: (waiter, form) ->
    if waiter and waiter.isPersisted()
      @original_form_waiter = angular.copy waiter

    @form_waiter = waiter
    form.$setPristine() if form

  setBlankFormWaiter: (form) ->
    @setFormWaiter (new @Waiter), form

  cancelWaiterEdit: (form) ->
    if @original_form_waiter
      @waiters[@original_form_waiter.id] = @original_form_waiter
      @updateAuxiliarDataStructures()

    @clearFormWaiter form

  clearFormWaiter: (form) ->
    @original_form_waiter = null
    @setFormWaiter null, form

  saveFormWaiter: (form) =>
    if form.$valid
      form.$setPristine()
      if @form_waiter.isPersisted()
        @service.update @form_waiter, @waiterUpdated
      else
        @service.create @form_waiter, @waiterUpdated

WaitersController.$inject = ['$scope', '$state', 'Waiter', 'WaitersService']
angular.module('RestaurantPosWeb').controller 'WaitersController', WaitersController
