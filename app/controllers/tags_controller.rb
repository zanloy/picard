class TagsController < ApplicationController
  def index
    @tags = Tag.all
    @tags_with_weight = []
    @tags.each do |tag|
      @tags_with_weight << {
        text: tag.name,
        weight: tag.taggings.count,
        link: tag_path(tag),
      }
    end
  end

  def show
    @tag = Tag.find(name_param)
    #@taggables = @tag.taggables
  end

  private

  def name_param
    params.require(:name)
  end
end
