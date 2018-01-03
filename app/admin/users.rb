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
    column "age" do |user|
      user.age
    end
    column :gender
    column :status
    column :anniversary
    column :mobileno
    column :address
    column :sign_in_count
    column :last_sign_in_at
    column :is_admin
    actions defaults: false do |user|
      if user.email == current_user.email
        link_to t('active_admin.edit'), edit_admin_user_path(user)
      end    
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
      f.input :status, as: :select, include_blank: false, collection: User::STATUS
      f.input :anniversary, include_blank: false, as: :datepicker
      f.input :gender, as: :select, include_blank: false, collection: User::GENDER
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
      # get the currently logged in AdminUser's id
      current_id = current_user.id
      # load the AdminUser being updated
      @admin_user = User.find(params[:id])
      # update the AdminUser with new attributes
      # if successful, this will sign out the AdminUser being updated
      if @admin_user.update_attributes(permitted_params[:user])
        # if the updated AdminUser was the currently logged in AdminUser, sign them back in
        if @admin_user.id == current_id
          sign_in(User.find(current_id), :bypass => true)
        end
        flash[:notice] = 'User details have been updated successfully'
        redirect_to '/admin/users'
      # display errors
      else
        super
      end
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
      row "age" do |user|
        user.age
      end
      row :anniversary
      row :status
      row :address
      row :mobileno
    end
    active_admin_comments
  end

end
