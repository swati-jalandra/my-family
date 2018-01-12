class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders do |t|
      t.string :purpose
      t.date :reminder_date
      t.integer :user_id		
      t.timestamps
    end
  end
end
