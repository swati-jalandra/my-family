class Document < ApplicationRecord
  CONTENT_TYPE = %w(image/jpeg
                    image/jpg
                    image/png
                    application/pdf
                    application/msword
                    application/vnd.openxmlformats-officedocument.wordprocessingml.document
                    text/plain)
  ZIP_FILE = 'download_files.zip'

  has_attached_file :file,
                    storage: :cloudinary,
                    path: ':id/:style/:filename',
                    cloudinary_credentials: Rails.root.join('config/cloudinary.yml'),
                    cloudinary_resource_type: :raw

  belongs_to :user

  validates :name, presence: true
  validates_attachment :file, content_type: { content_type: CONTENT_TYPE }

  def self.zip(documents)
    archive = File.join(ZIP_FILE)
    File.truncate(archive, 0) if File.exist? archive
    Zip::File.open(archive, Zip::File::CREATE) do |zip_file|
      documents.each do |document|
        zip_file.add(document.file_file_name,document.file.path)
      end
    end
    archive
  end
end
