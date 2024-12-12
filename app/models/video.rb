class Video < ApplicationRecord
  has_one_attached :video
  has_one :content, as: :contentable, dependent: :destroy
  accepts_nested_attributes_for :content

  before_validation :build_content_if_nil, on: :create
  delegate :title, :description, to: :content, allow_nil: true

  private

  def build_content_if_nil
    if content.nil?
      build_content(title: title, description: description)
    end
  end
end
