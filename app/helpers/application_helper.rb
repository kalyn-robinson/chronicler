module ApplicationHelper
  
  # Returns full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'Chronicler'
    if page_title.empty?
      base_title
    else
      base_title + ' | ' + page_title
    end
  end

  def class_string(css_map)
    classes = []

    css_map.each do |css, bool|
      classes << css if bool
    end
    
    classes.join(" ")
  end
end
