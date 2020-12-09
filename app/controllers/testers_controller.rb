# frozen_string_literal: true

class TestersController < ApplicationController
  def index
    @card = RandomCardQuery.new(current_user).call
  end

  def create
    @card = Card.find(params[:card_id]).decorate
    case checker.call
    when :correct
      flash[:info] = I18n.t('card.note.it_true')
    when :incorrect_with_reset
      flash[:danger] = I18n.t('card.note.incorrect_with_reset', translate: @card.translated_text)
    when :incorrect
      flash[:warning] = I18n.t('card.note.incorrect', count: checker.attempts_left)
    end
    redirect_back(fallback_location: testers_path)
  end

  def checker
    @checker ||= CheckCard.new(@card, params[:answer])
  end
end
