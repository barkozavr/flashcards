class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def show
    @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path
      flash[:info] = t('saved')
    else
      flash.now[:warning] = t('fail')
      render 'new'
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end
end
