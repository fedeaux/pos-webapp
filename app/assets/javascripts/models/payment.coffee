angular.module('RestaurantPosWeb').factory 'Payment', ($resource) ->
  class Payment
    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes) ->
      for name, default_value of @defaultAttributes()
        if attributes.hasOwnProperty(name) and attributes[name] != null
          @[name] = attributes[name]
        else
          @[name] = default_value

      if @value
        @value = parseFloat @value

    isPersisted: ->
      !! @id

    defaultAttributes: ->
      attr =
        id: null
        value: 0
        observations: null

      attr

    attributes: ->
      attr = {}

      for name, default_value of @defaultAttributes()
        attr[name] = @[name]

      attr
