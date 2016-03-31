class ReviewsController < ApplicationController

  before_filter :load_movie 
  before_filter :restrict_access

  def new
    @review = @poem.reviews.build
  end

  def create
    @review = @poem.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to @poem, notice: "Review created successfully"
    else
      render :new
    end
  end

  protected

  def load_movie
    @poem = Poem.find(params[:poem_id])
  end

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end
end
