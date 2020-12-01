# frozen_string_literal: true

class CardDecorator < Draper::Decorator
  delegate_all

  def current_picture
    return unless picture
    h.tag :img, src: picture.url
  end
end
