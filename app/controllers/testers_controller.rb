class TestersController < ApplicationController
  def index
    @card = current_user.cards.random_card
  end

  def create
    @card = Card.find(params[:card_id])
    if CheckCard.new(@card).check_translation(params[:answer])
      flash[:info] = t('card.note.it_true')
    else
      flash[:warning] = t('card.note.it_false')
    end
    redirect_back(fallback_location: testers_path)
  end
end
