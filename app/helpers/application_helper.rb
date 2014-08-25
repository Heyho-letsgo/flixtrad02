module ApplicationHelper

  def page_title
    if content_for?(:title)
      content_for(:title)
    else
      "Flix"
    end
  end

end