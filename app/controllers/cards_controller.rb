class CardsController < ApplicationController
  before_action :find_card, only: %i[show edit update destroy]

  def index
    @cards = current_user.cards.decorate
  end

  def new
    @card = current_user.cards.build.decorate
  end

  def show; end

  def create
    @card = current_user.cards.build(card_params).decorate
    if @card.save
      redirect_to cards_path
      flash[:info] = t('card.note.saved')
    else
      flash.now[:warning] = t('card.error.fail')
      render 'new'
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to card_path(@card), notice: t('card.note.changed')
    else
      flash.now[:warning] = t('card.error.fail')
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path, notice: t('card.note.deleted')
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :picture, :remote_picture_url, :deck_id)
  end

  def find_card
    @card = current_user.cards.find_by(id: params[:id]).decorate
    redirect_to cards_path unless @card
  end
end
