# app/helpers/application_helper.rb
module ApplicationHelper
    def image_exists?(image)
      image.attached?
    end
  end
  