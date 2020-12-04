# frozen_string_literal: true

class DecksController < ApplicationController
  before_action :set_deck, only: %i[show edit update destroy]

  def index
    @decks = current_user.decks
  end

  def new
    @deck = current_user.decks.build
  end

  def show; end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to decks_path, notice: t('deck.note.created')
    else
      flash.now[:warning] = t('card.error.fail')
      render :new
    end
  end

  def edit; end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path, notice: t('deck.note.edited')
    else
      flash.now[:warning] = t('card.error.fail')
      render :edit
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path, notice: t('deck.note.deleted')
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name, :current)
  end
end
