class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :type
      t.string :name
      t.string :user_id
      t.attachment :file
      t.timestamps
    end
  end
end
