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
    @previous_table_state = @selected_table.state
    @selected_table.state = state
    @service.update @selected_table, @tableUpdated

  tableUpdated: (response) =>
    @setTable response.table
    @updateAuxiliarDataStructures()

    if @previous_table_state == 'available' and @selected_table.state == 'occupied'
      @previous_table_state = null
      @scope.$broadcast 'TablesController::TableOccupied'

  setTable: (table_attributes) =>
    @tables[table_attributes.id] = new @Table table_attributes

    if @selected_table and @selected_table.id == table_attributes.id
      @selected_table = @tables[table_attributes.id]

  clearSelectedTable: =>
    @selected_table = null

  updateAuxiliarDataStructures: =>
    @displayable_tables = (table for id, table of @tables)

  save: =>

TablesController.$inject = ['$scope', '$state', 'Table', 'TablesService']
angular.module('RestaurantPosWeb').controller 'TablesController', TablesController
