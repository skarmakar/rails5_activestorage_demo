class Post < ApplicationRecord
  validates :title, :photo, presence: true
  has_one_attached :photo

  def as_json(options = {})
    attributes.merge(photo_url: Rails.application.routes.url_helpers.url_for(photo))
  end
end
