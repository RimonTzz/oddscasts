class Article < ApplicationRecord
  has_one_attached :cover
  has_one :content, as: :contentable, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :content

  # Ensure content is created if it doesn't exist
  before_validation :build_content_if_nil, on: :create

  delegate :title, :description, to: :content, allow_nil: true
  
  private

  def build_content_if_nil
    # Build the associated content if it doesn't already exist
    build_content if content.nil?
  end
end
