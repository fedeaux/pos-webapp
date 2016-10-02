angular.module('RestaurantPosWeb').factory 'ReportsService', ($resource, $http, ResourceService) ->
  class ReportsService extends ResourceService
    constructor: ->
      super @errorHandler, 'report', 'reports', 'v1/reports/:id'

    downloadAsPdf: (report) ->
      $http(
        url: "#{config.api_url}/v1/reports/#{report.id}/download_as_pdf"
        method: 'get'
        params: {}
        headers: 'Content-type': 'application/pdf'
        responseType: 'arraybuffer'

      ).success (data, status, headers, config) ->
        file = new Blob([ data ], type: 'application/csv')
        #trick to download store a file having its URL
        fileURL = URL.createObjectURL(file)
        a = document.createElement('a')
        a.href = fileURL
        a.target = '_blank'
        a.download = "#{report.formatted_start} #{report.formatted_finish} #{report.list_reporters}.pdf"
        document.body.appendChild a
        a.click()
