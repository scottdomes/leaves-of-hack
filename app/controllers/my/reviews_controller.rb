class My::ReviewsController < ApplicationController

  def index
    @reviews = Review.where(user_id: current_user.id)
  end

end
