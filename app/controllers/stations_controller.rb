class StationsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    # @stations = Station.all.sort_by{|station| station.name.split(' ').sort.join(' ')}
    @stations = Station.all.sort_by{|station| station.lines.map{|l| l.name}.sort.join(' ')}
  end

  def combine
    from = Station.find params[:from]
    to = Station.find params[:to]
    typo = params[:typo] == "true"

    from.stops.each do |stop|
      stop.update_attribute(:name, from.name) if typo
      to.stops << stop
    end

    from.destroy
    render :nothing => true
  end
end
