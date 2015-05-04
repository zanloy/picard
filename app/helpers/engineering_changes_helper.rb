module EngineeringChangesHelper

  def display_title(change, with_icon = true)
    if with_icon
      result = link_to glyphicon(:link), engineering_change_path(change)
      result += raw '&nbsp;'
    else
      result = ''
    end
    result += raw linkify_tags change.title
    return result
  end

end
