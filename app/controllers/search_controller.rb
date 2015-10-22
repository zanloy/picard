class SearchController < ApplicationController

  def index
    authorize! :search, EngineeringChange
    @results = EngineeringChange.search query
  end

  private

  def query
    params.require(:query)
  end

end
