class CreateContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :contacts do |t|
      t.string :phone_number
      t.string :status
      t.datetime :last_called_at
      t.string :last_call_sid

      t.timestamps
    end
  end
end
