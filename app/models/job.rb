class Job < ApplicationRecord
  belongs_to :company
  #has_many :images, as: :imageable
  has_many :job_hiring_types
  has_many :hiring_types, through: :job_hiring_types
  has_many :pictures, as: :pictureable

  accepts_nested_attributes_for :job_hiring_types,
    reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pictures
  # ATTRIBUTES = [:title, :describe, :type_of_candidates,
  #   :who_can_apply, :imageable_id, :image_url, :imageable_type,
  #   :company_id, :hiring_type_ids => []]

  ATTRIBUTES = [:title, :describe, :type_of_candidates,
    :who_can_apply, :company_id, :hiring_type_ids => [],
    pictures_attributes: [:id, :pictureable_id, :pictureable_type, :picture, :caption]]


  validates :title, presence: true, length: {maximum: Settings.max_length_title}
  validates :describe, presence: true

  scope :newest, ->{order created_at: :desc}

  # after_create :create_image

  # private

  # def create_image
  #   Image.create(
  #     imageable_id: self.id,
  #     imageable_type: "Type of job",
  #     image_url: :image_url,
  #     caption: :caption
  #   )
  # end
end
