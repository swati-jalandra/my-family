ActiveAdmin.register CollegeDoc do
  menu :parent => "My Documents"

  permit_params :file, :type, :name

  index do
    selectable_column
    column :name
    column 'file' do |document|
      link_to 'Download', document.file.url(:original, false), target: '_blank'
    end
    actions
  end

  filter :name
  filter :file


  form do |f|
    f.inputs 'College Doc Details' do
      f.input :name
      f.input :file, required: true, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :file do |document|
        link_to 'Download', document.file.url(:original, false), target: '_blank'
      end
    end
    active_admin_comments
  end
end