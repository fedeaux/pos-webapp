class ReportController
  constructor: (@scope, @state, @stateParams, @Report, @MonthlyTimeRange, @ReportsService) ->
    window.ctrl = @
    @service = new @ReportsService
    @report_id = @stateParams.id
    @loadReport()

  loadReport: ->
    @service.get @report_id, @setReport

  setReport: (response) =>
    @report = new @Report response.report
    @results = response.results

ReportController.$inject = ['$scope', '$state', '$stateParams', 'Report', 'MonthlyTimeRange', 'ReportsService']
angular.module('RestaurantPosWeb').controller 'ReportController', ReportController
