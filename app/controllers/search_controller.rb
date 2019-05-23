# frozen_string_literal: true

# Controller for Search
class SearchController < ApplicationController
  def index
    authorize! :search, EngineeringChange
    begin
      @results = EngineeringChange.search query
    rescue Searchkick::MissingIndexError
      EngineeringChange.reindex
      @results = EngineeringChange.search query
    end
  end

  private

  def query
    params.require(:query)
  end
end
