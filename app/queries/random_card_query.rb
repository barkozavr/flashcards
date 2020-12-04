# frozen_string_literal: true

class RandomCardQuery
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def call
    scope = user.decks.find_by(current: true) || user
    @card = scope.cards.random_card&.decorate
  end
end
