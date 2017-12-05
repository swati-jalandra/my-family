require 'rubygems'
require 'zip'

folder = "/Users/ram/Desktop"
input_filenames = ['image1.jpeg', 'my-family-logo.jpeg']

zipfile_name = "/Users/ram/Desktop/personal-docs.zip"

Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
  input_filenames.each do |filename|
    # Two arguments:
    # - The name of the file as it will appear in the archive
    # - The original file, including the path to find it
    zipfile.add(filename, File.join(folder, filename))
  end
end

# Public folder is getting reset during each deployment