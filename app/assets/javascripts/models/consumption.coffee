angular.module('RestaurantPosWeb').factory 'Consumption', ($resource) ->
  class Consumption
    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes) ->
      for name, default_value of @defaultAttributes()
        if attributes.hasOwnProperty(name) and attributes[name] != null
          @[name] = attributes[name]
        else
          @[name] = default_value

      @total_price = parseFloat @total_price if @total_price
      @payed_value = parseFloat @payed_value if @payed_value
      @setAuxiliarAttributes()

    isPersisted: ->
      !! @id

    defaultAttributes: ->
      attr =
        id: null
        total_price: 0
        payed_value: 0
        state: null

      attr

    setAuxiliarAttributes: ->
      if @total_price and @payed_value
        @expected_discount = Math.max (@total_price - @payed_value), 0
        @expected_tip = Math.max (@payed_value - @total_price), 0

    attributes: ->
      attr = {}

      for name, default_value of @defaultAttributes()
        attr[name] = @[name]

      attr
