class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :release_date, presence: true
  validates_processing_of :image
  validate :image_size_validation

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size unless reviews.size == 0
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def image_size_validation 
    if image.size > 0.5.megabytes
      errors.add(:image, "should be less than 500kb")
    end
  end

end
