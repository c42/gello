class CardsController < ApplicationController
  def update
    card = Card.find(params['id'])
    card.lane = params['lane']
    card.save!
    head :ok
  end
end
