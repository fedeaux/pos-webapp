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
        @setTable table_attributes

      @updateAuxiliarDataStructures()

  addTable: ->
    @service.create @tableUpdated

  setSelectedTable: (table) =>
    @selected_table = table
    @scope.$broadcast 'TablesController::TableSelected', table: @selected_table

  setSelectedTableState: (state) =>
    @selected_table.state = state
    @service.update @selected_table, @tableUpdated

  tableUpdated: (response) =>
    @setTable response.table
    @updateAuxiliarDataStructures()

  setTable: (table_attributes) =>
    @tables[table_attributes.id] = new @Table table_attributes

  clearSelectedTable: =>
    @selected_table = null

  updateAuxiliarDataStructures: =>
    @displayable_tables = (table for id, table of @tables)

  save: =>

TablesController.$inject = ['$scope', '$state', 'Table', 'TablesService']
angular.module('RestaurantPosWeb').controller 'TablesController', TablesController
