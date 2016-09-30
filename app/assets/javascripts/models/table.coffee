angular.module('RestaurantPosWeb').factory 'Table', ($resource) ->
  class Table
    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes) ->
      for name, default_value of @defaultAttributes()
        if attributes.hasOwnProperty(name) and attributes[name] != null
          @[name] = attributes[name]
        else
          @[name] = default_value

    isPersisted: ->
      !! @id

    defaultAttributes: ->
      attr =
        id: null
        state: null

      attr

    attributes: ->
      attr = {}

      for name, default_value of @defaultAttributes()
        attr[name] = @[name]

      attr
