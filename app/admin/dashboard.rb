ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    render partial: 'notifications'

    columns do
      column do
        panel "What's special today in #{Rails.env} environment ?" do
          render partial: 'special_day'
        end
      end
    end

    columns do
      column do
        panel "Login Count" do
          render partial: 'user_login_count'
        end
      end

      column do
        panel "Total number of documents per person" do
          render partial: 'top_documents'
        end
      end
    end

    @users = User.all

    @users.each do |user|
      columns do
        column do
          @personal_docs = user.personal_docs
          @personal_docs.each_with_index { |personal_doc, index| personal_doc.doc_number = index+1 }
          panel "Personal documents - #{user.name}" do
            if @personal_docs.present?
              table_for @personal_docs do |t|
                t.column("No") { |doc| doc.doc_number }
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
          @official_docs.each_with_index { |official_doc, index| official_doc.doc_number = index+1 }
          panel "Official documents - #{user.name}" do
            if @official_docs.present?
              table_for @official_docs do |t|
                t.column("No") { |doc| doc.doc_number }
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
          @educational_docs.each_with_index { |educational_doc, index| educational_doc.doc_number = index+1 }
          panel "Educational documents - #{user.name}" do
            if @educational_docs.present?
              table_for @educational_docs do |t|
                t.column("No") { |doc| doc.doc_number }
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

def users
  User.all.map do |user|
    {}.tap do |users|
      users[:name] = user.first_name
      users[:count] = user.sign_in_count
    end
  end
end

def top_documents
  User.all.map do |user|
    {}.tap do |users|
      users[:name] = user.first_name
      users[:count] = user.documents.count
     end 
  end
end

