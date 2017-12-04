ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :is_admin

  index do
    selectable_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :is_admin
    if current_user.is_admin
      actions
    end
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :is_admin

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :is_admin
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

end
