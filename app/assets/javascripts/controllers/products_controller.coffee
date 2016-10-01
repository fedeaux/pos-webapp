class ProductsController
  constructor: (@scope, @state, @Product, @ProductsService, @ProductCategoriesService) ->
    window.ctrl = @
    @service = new @ProductsService
    @categories_service = new @ProductCategoriesService
    @form_product = null

    @loadProducts()
    @loadCategories()

  loadProducts: ->
    @service.index @setProducts

  loadCategories: ->
    @categories_service.index @setCategories

  setCategories: (response) =>
    @available_categories = response.product_categories

  setProducts: (response) =>
    @products = {}

    if response.products
      for product_attributes in response.products
        @setProduct product_attributes

      @updateAuxiliarDataStructures()

  productUpdated: (response) =>
    @setProduct response.product
    @clearFormProduct()
    @updateAuxiliarDataStructures()

  setProduct: (product_attributes) =>
    @products[product_attributes.id] = new @Product product_attributes

  updateAuxiliarDataStructures: =>
    @displayable_products = (product for id, product of @products)

  setFormProduct: (product) ->
    @form_product = product

  setBlankFormProduct: ->
    @setFormProduct new @Product

  clearFormProduct: ->
    @setFormProduct null

  saveFormProduct: =>
    if @form_product.isPersisted()
      @service.update @form_product, @productUpdated
    else
      @service.create @form_product, @productUpdated

ProductsController.$inject = ['$scope', '$state', 'Product', 'ProductsService', 'ProductCategoriesService']
angular.module('RestaurantPosWeb').controller 'ProductsController', ProductsController
