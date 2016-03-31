class My::PoemsController < ApplicationController

  def index
    @poems = Poem.where(user_id: current_user.id)
  end

end
