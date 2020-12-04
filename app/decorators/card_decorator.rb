# frozen_string_literal: true

class CardDecorator < Draper::Decorator
  delegate_all

  def current_picture(quality = nil)
    return unless picture
    h.tag :img, src: picture.url(quality)
  end
end
