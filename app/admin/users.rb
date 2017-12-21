ActiveAdmin.register User do
  permit_params :first_name, :last_name, :dob, :gender,
                :mobileno, :address, :email, :password,
                :password_confirmation, :is_admin,
                :anniversary, :status

  index do
    selectable_column
    column "Name" do |user|
      user.name
    end
    column :email
    column :dob
    column :gender
    column :status
    column :anniversary
    column :mobileno
    column :address
    column :sign_in_count
    column :last_sign_in_at
    column :is_admin
    if current_user.is_admin
      actions
    end
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :dob
  filter :gender
  filter :status
  filter :anniversary
  filter :mobileno
  filter :address
  filter :current_sign_in_at
  filter :sign_in_count
  filter :is_admin

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :dob, include_blank: false, as: :datepicker
      f.input :status
      f.input :anniversary, include_blank: false, as: :datepicker
      f.input :gender
      f.input :mobileno
      f.input :address
      f.input :is_admin
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end

    def action_methods
      if current_user.is_admin
        super
      else
        super - ['new']
      end
    end
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :gender
      row :dob
      row :anniversary
      row :status
      row :address
      row :mobileno
    end
    active_admin_comments
  end

end
