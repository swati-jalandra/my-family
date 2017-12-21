class AddStatusAnniversaryDateToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :anniversary, :date
    add_column :users, :status, :string
  end
end
