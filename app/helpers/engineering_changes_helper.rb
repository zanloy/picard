module EngineeringChangesHelper

  def display_title(change)
    result = link_to(change.title, engineering_change_path(change))
    #change.tags.each { |tag| result += content_tag(:span, "##{tag.name} ", class: 'tag') }
    return result
  end

end
