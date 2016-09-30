class TablesController
  constructor: (@scope, @state, @Table, @TablesService) ->
    @service = new @TablesService
    @loadTables()

  loadTables: ->
    @service.index @setTables

  setTables: (response) =>
    @tables = {}

    if response.tables
      for table_attributes in response.tables
        @tables[table_attributes.id] = new @Table table_attributes

      @updateAuxiliarDataStructures()

  setSelectedTable: (table) =>
    @selected_table = table

  clearSelectedTable: =>
    @selected_table = null

  updateAuxiliarDataStructures: =>
    @displayable_tables = (table for id, table of @tables)

  save: =>

TablesController.$inject = ['$scope', '$state', 'Table', 'TablesService']
angular.module('RestaurantPosWeb').controller 'TablesController', TablesController
