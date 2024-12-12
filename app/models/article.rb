class Article < ApplicationRecord
  has_one_attached :cover
  has_one :content, as: :contentable, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :content

  # Ensure content is created if it doesn't exist
  before_validation :build_content_if_nil, on: :create

  delegate :title, :description, to: :content, allow_nil: true
  validate :validate_restricted_words_in_title

  private

  def build_content_if_nil
    build_content if content.nil?
  end

  def validate_restricted_words_in_title
    restricted_words = YAML.load_file(Rails.root.join("config/restricted_words.yml"))["restricted_words"]

    if title.present? && restricted_words.any? { |word| title.downcase.include?(word) }
      errors.add(title, "contains restricted language and cannot be saved")
    end
  end
end
