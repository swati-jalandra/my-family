class Document < ApplicationRecord
  CONTENT_TYPE = %w(image/jpeg
                    image/jpg
                    image/png
                    application/pdf
                    application/msword
                    application/vnd.openxmlformats-officedocument.wordprocessingml.document
                    text/plain)
  has_attached_file :file
  belongs_to :user

  validates :name, presence: true
  validates_attachment :file, content_type: { content_type: CONTENT_TYPE }
end
