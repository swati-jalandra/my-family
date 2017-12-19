ActiveAdmin.register OfficialDoc do
  menu :parent => "My Documents"

  permit_params :file, :type, :name, :user_id

  index do
    selectable_column
    @index = 30 * (((params[:page] || 1).to_i) - 1) # 30 needs to set to that what your page size is
    column :no do
      @index += 1
    end
    column :name
    column 'file' do |document|
      link_to 'Download', document.file.url, target: :_blank
    end
    actions
  end

  filter :name
  filter :file

  action_item only: :index do
    unless current_user.official_docs.empty?
      link_to 'Download Files', export_admin_official_docs_path
    end
  end

  collection_action :export, method: :get do
    @official_docs = current_user.official_docs
    unless @official_docs.empty?
      send_file Document.zip(@official_docs),
                :type => 'application/zip',
                :disposition => 'attachment',
                :filename => "#{current_user.name}_official_docs.zip"
    end
  end

  # download file directly
  member_action :download, method: :get do
    @document = Document.find(params[:id])
    send_file @document.file.path
  end

  form do |f|
    f.inputs 'Official Doc Details' do
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
        link_to 'Download', document.file.url, target: :_blank
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