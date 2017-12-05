ActiveAdmin.register EducationalDoc do
  menu :parent => "My Documents"

  permit_params :file, :type, :name, :user_id

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
    f.inputs 'Educational Doc Details' do
      f.input :name
      f.input :file, required: true, as: :file
      f.input :user_id, :input_html => { :value => current_user.id }, as: :hidden
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

  controller do
    def scoped_collection
      end_of_association_chain.where(user_id: current_user.id)
    end
  end
end