class Picture < ApplicationRecord
  belongs_to :pictureable, polymorphic: true, optional: true, inverse_of: :pictures
  mount_uploader :picture, PictureUploader
end
