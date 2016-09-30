class DashboardController < ApplicationController
  def index
  end

  def template
    set_template_parameters
    render template_name, layout: false
  end

  private
  def template_name
    path = Rails.root.join('app', 'views', params[:name]).to_s.gsub(/\/$/, '')
    if File.exists?(path+'.html.erb') or File.exists?(path+'.html.haml')
      params[:name]
    else
      parts = params[:name].split('/')
      "/#{parts[0..-2].join('/')}/_#{parts.last}"
    end
  end

  def set_template_parameters
    @template_params = request.query_parameters.symbolize_keys
  end
end
