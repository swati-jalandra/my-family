ActiveAdmin.register Reminder do
  permit_params :purpose, :reminder_date, :user_id

  index do
    selectable_column
    column :purpose
    column :reminder_date
    actions
  end

  filter :purpose
  filter :reminder_date


  form do |f|
    f.inputs do
      f.input :purpose
      f.input :reminder_date, include_blank: false, as: :datepicker
    end
    f.actions
  end

  controller do
    def scoped_collection
      end_of_association_chain.where(user_id: current_user.id)
    end
  end

  show do
    attributes_table do
      row :purpose
      row :reminder_date
    end
    active_admin_comments
  end
end
