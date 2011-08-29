class StatisticsController < ApplicationController
  before_filter :current_user

  def show
    @catalog = Catalog.find(params[:catalog_id])
    @statistic = Statistic.find(params[:id])
  end

end
