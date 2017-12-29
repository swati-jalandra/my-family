class Document < ApplicationRecord
  attribute :doc_number, :integer
  CONTENT_TYPE = %w(image/jpeg
                    image/jpg
                    image/png
                    application/pdf
                    application/msword
                    application/vnd.openxmlformats-officedocument.wordprocessingml.document
                    text/plain)
  ZIP_FILE = 'download_files.zip'

  default_scope { order(created_at: :desc) }

  if Rails.env == 'production'
    has_attached_file :file,
                      storage: :cloudinary,
                      path: ':id/:style/:filename',
                      cloudinary_credentials: Rails.root.join('config/cloudinary.yml'),
                      cloudinary_resource_type: :raw
  else
    has_attached_file :file
  end

  belongs_to :user

  validates :name, presence: true
  validates_attachment :file, content_type: { content_type: CONTENT_TYPE }

  def cloud_path
    Rails.env == 'production' ? open(file.url).path : file.path
  end

  def self.zip(documents)
    archive = File.join(ZIP_FILE)
    File.truncate(archive, 0) if File.exist? archive
    Zip::File.open(archive, Zip::File::CREATE) do |zip_file|
      documents.each do |document|
        zip_file.add(document.file_file_name,document.cloud_path)
      end
    end
    archive
  end
end
