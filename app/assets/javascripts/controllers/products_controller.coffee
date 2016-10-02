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

  setFormProduct: (product, form) ->
    if product and product.isPersisted()
      @original_form_product = angular.copy product

    @form_product = product
    form.$setPristine() if form

  setBlankFormProduct: (form) ->
    @setFormProduct (new @Product), form

  cancelProductEdit: (form) ->
    if @original_form_product
      @products[@original_form_product.id] = @original_form_product
      @updateAuxiliarDataStructures()

    @clearFormProduct form

  clearFormProduct: (form) ->
    @original_form_product = null
    @setFormProduct null, form

  saveFormProduct: (form) =>
    if form.$valid
      form.$setPristine()
      if @form_product.isPersisted()
        @service.update @form_product, @productUpdated
      else
        @service.create @form_product, @productUpdated

ProductsController.$inject = ['$scope', '$state', 'Product', 'ProductsService', 'ProductCategoriesService']
angular.module('RestaurantPosWeb').controller 'ProductsController', ProductsController
