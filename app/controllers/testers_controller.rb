# frozen_string_literal: true

class TestersController < ApplicationController
  def index
    @card = RandomCardQuery.new(current_user).call
  end

  def create
    @card = Card.find(params[:card_id]).decorate
    handle_check_result(CheckCard.new(@card, params[:answer]))
    redirect_back(fallback_location: testers_path)
  end

  def handle_check_result(tester)
    case tester.call
    when :correct
      flash[:info] = I18n.t('card.note.it_true')
    when :correct_with_one_typo
      flash[:info] = I18n.t('card.note.it_true_with_typo', answ: params[:answer], translate: @card.translated_text)
    when :incorrect_with_reset
      flash[:danger] = I18n.t('card.note.incorrect_with_reset', translate: @card.translated_text)
    when :incorrect
      flash[:warning] = I18n.t('card.note.incorrect', count: tester.attempts_left)
    end
  end
end
