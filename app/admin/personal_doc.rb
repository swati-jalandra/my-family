ActiveAdmin.register PersonalDoc do
  menu :parent => "My Documents"
  config.comments = false

  permit_params :file, :type, :name, :user_id

  index do
    selectable_column
    column :name
    column 'file' do |document|
      link_to 'Download', download_admin_personal_doc_path(document)
    end
    actions
  end

  filter :name
  filter :file

  action_item only: :index do
    unless current_user.personal_docs.empty?
      link_to 'Download Files', export_admin_personal_docs_path
    end
  end

  collection_action :export, method: :get do
    @personal_docs = current_user.personal_docs
    unless @personal_docs.empty?
      send_file Document.zip(@personal_docs),
                :type => 'application/zip',
                :disposition => 'attachment',
                :filename => "#{current_user.name}_personal_docs.zip"
    end
  end

  member_action :download, method: :get do
    @document = Document.find(params[:id])
    send_file @document.file.path
  end

  form do |f|
    f.inputs 'Personal Doc Details' do
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