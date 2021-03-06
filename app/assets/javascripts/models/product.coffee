angular.module('RestaurantPosWeb').factory 'Product', ($resource) ->
  class Product
    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes) ->
      for name, default_value of @defaultAttributes()
        if attributes.hasOwnProperty(name) and attributes[name] != null
          @[name] = attributes[name]
        else
          @[name] = default_value

      if @category.id
        @category_id = @category.id

      if @price
        @price = parseFloat @price

    isPersisted: ->
      !! @id

    defaultAttributes: ->
      attr =
        id: null
        name: null
        price: 0
        code: null
        category_id: null
        category: {}

      attr

    attributes: ->
      attr = {}

      for name, default_value of @defaultAttributes()
        attr[name] = @[name]

      attr
