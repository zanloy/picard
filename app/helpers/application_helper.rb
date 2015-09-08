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
    return nil unless body
    body.gsub(/#\w+/) do |hashtag|
      tag = hashtag[1..-1]
      if tag == nil
        hashtag
      else
        link_to hashtag, tag_path(tag.downcase.strip)
      end
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

  def markdown(text)
    return nil if text.nil?
    renderer_options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      prettify: true,
    }

    markdown_options = {
      autolink: true,
      disable_indented_code_blocks: false,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      space_after_headers: true,
      superscript: true,
    }

    renderer = Redcarpet::Render::HTML.new(renderer_options)
    markdown = Redcarpet::Markdown.new(renderer, markdown_options)

    markdown.render(text).html_safe
  end

  def display_attachment_inline(attachment)
    if attachment.file_content_type =~ /^image/
      return image_tag(attachment.file.url(:original))
    else
      return link_to(attachment.file_file_name, attachment.file.url(:original, false), target: '_blank')
    end
  end

  def display_description(change)
    # Link tags
    text = linkify_tags(change.description)
    # Parse markdown
    text = markdown(text)
    # Embed attachments
    change.attachments.each do |attachment|
      text.sub!("[#{attachment.reference}]", display_attachment_inline(attachment))
    end
    return text
  end

end
