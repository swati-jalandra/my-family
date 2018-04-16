ActiveAdmin.register_page "Chat" do
  content do
    render partial: 'message', :locals => { :messages => Message.all }
  end
end
