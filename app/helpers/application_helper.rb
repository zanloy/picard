module ApplicationHelper

  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end

  def glyphicon(icon)
    content_tag :i, nil, class: "glyphicon glyphicon-#{icon.to_s}"
  end

  def delete_icon
    glyphicon :trash
  end

  def check_icon(value)
    glyphicon :ok if value == true
  end

  def check_box_icon(value)
    case value
    when true then glyphicon :check
    when false then glyphicon :unchecked
    else ''
    end
  end

  def linkify_tags(body)
    body.gsub(/#[\w]*/) do |hashtag|
      tag = hashtag[1..-1]
      link_to(hashtag, tag_path(tag))
    end
  end

  def display_name(user)
    return '' if user == nil
    if user.admin
      "#{glyphicon(:king)} #{link_to user.name, user_path(user)}"
    else
      link_to user.name, user_path(user)
    end
  end

  def display_environment(environment)
    link_to environment.name, environment_path(environment)
  end

  def display_email(value)
    return if value.nil? or value.empty?
    link_to value, "mailto:#{value}"
  end

  def display_tags(item)
    return if not item.respond_to? :tags
    result = ''
    item.tags.each do |tag|
      result += "<span class='tag'>#{tag.name}</span> "
    end
    return result
  end

  def display_phone_number(value)
    return if value.nil? or value.empty?
    link_to value, "tel:#{value}"
  end

end
