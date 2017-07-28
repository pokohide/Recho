module UsersHelper
  def thumbnail_tag(user, options = {})
    class_name = options[:class].blank? ? 'thumbnail' : options[:class].to_s + ' thumbnail'
    if user.try(:image).present?
      image_tag user.image(:thumbnail), class: class_name
    else
      image_tag 'user.png', class: class_name
    end
  end
end
