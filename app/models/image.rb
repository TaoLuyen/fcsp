class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true, inverse_of: :images
end
