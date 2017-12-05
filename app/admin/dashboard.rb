ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    @users = User.all

    @users.each do |user|
      columns do
        column do
          @personal_docs = user.personal_docs
          panel "Personal documents - #{user.name}" do
            if @personal_docs.present?
              table_for @personal_docs do |t|
                t.column("Name") { |doc| doc.name }
                t.column("Created Date") { |doc| doc.created_at ? l(doc.created_at, :format => :long) : '-' }
              end
            else
               'No documents created yet'
            end
          end
        end

        column do
          @official_docs = user.official_docs
          panel "Official documents - #{user.name}" do
            if @official_docs.present?
              table_for @official_docs do |t|
                t.column("Name") { |doc| doc.name }
                t.column("Created Date") { |doc| doc.created_at ? l(doc.created_at, :format => :long) : '-' }
              end
            else
              'No documents created yet'
            end
          end
        end

        column do
          @educational_docs = user.educational_docs
          panel "Educational documents - #{user.name}" do
            if @educational_docs.present?
              table_for @educational_docs do |t|
                t.column("Name") { |doc| doc.name }
                t.column("Created Date") { |doc| doc.created_at ? l(doc.created_at, :format => :long) : '-' }
              end
            else
              'No documents created yet'
            end
          end
        end
      end
    end



  end # content
end
