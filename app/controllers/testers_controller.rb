# frozen_string_literal: true

class TestersController < ApplicationController
  def index
    @card = RandomCardQuery.new(current_user).call
  end

  def create
    @card = Card.find(params[:card_id]).decorate
    if CheckCard.new(@card).check_translation(params[:answer])
      flash[:info] = t('card.note.it_true')
    else
      flash[:warning] = t('card.note.it_false')
    end
    redirect_back(fallback_location: testers_path)
  end
end
