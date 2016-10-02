class ReportsController
  constructor: (@scope, @state, @Report, @MonthlyTimeRange, @ReportsService) ->
    window.ctrl = @
    @service = new @ReportsService

    @form_report = null
    @loadReports()

  loadReports: ->
    @service.index @setReportsAndRange

  setReportsAndRange: (response) =>
    @reports = {}

    if response.reports
      for report_attributes in response.reports
        @setReport report_attributes

      @updateAuxiliarDataStructures()

    @time_range = new @MonthlyTimeRange moment(response.available_period.earliest), moment(response.available_period.latest)
    @reporters = response.available_reporters

  reportUpdated: (response) =>
    @setReport response.report
    @clearFormReport()
    @updateAuxiliarDataStructures()

  setReport: (report_attributes) =>
    @reports[report_attributes.id] = new @Report report_attributes

  updateAuxiliarDataStructures: =>
    @displayable_reports = (report for id, report of @reports)

  setFormReport: (report, form) ->
    if report and report.isPersisted()
      @original_form_report = angular.copy report

    @form_report = report
    form.$setPristine() if form

  setBlankFormReport: (form) ->
    @setFormReport (new @Report), form

  cancelReportEdit: (form) ->
    if @original_form_report
      @reports[@original_form_report.id] = @original_form_report
      @updateAuxiliarDataStructures()

    @clearFormReport form

  clearFormReport: (form) ->
    console.log 'oi'
    @original_form_report = null
    @setFormReport null, form

  saveFormReport: (form) =>
    if form.$valid
      form.$setPristine()
      if @form_report.isPersisted()
        @service.update @form_report, @reportUpdated
      else
        @service.create @form_report, @reportUpdated

ReportsController.$inject = ['$scope', '$state', 'Report', 'MonthlyTimeRange', 'ReportsService']
angular.module('RestaurantPosWeb').controller 'ReportsController', ReportsController
