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
    @taggables = {
      changes: [],
      comments: [],
    }
    @tag.taggings.each do |tagging|
      case tagging.taggable_type
      when 'EngineeringChange'
        @taggables[:changes] << tagging.taggable
      when 'Comment'
        @taggables[:comments] << tagging.taggable
      end
    end
  end

  private

  def name_param
    params.require(:name)
  end
end
