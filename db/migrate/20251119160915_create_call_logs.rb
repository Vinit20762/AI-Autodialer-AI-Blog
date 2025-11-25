class CreateCallLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :call_logs do |t|
      t.string :phone_number
      t.string :status
      t.integer :duration
      t.datetime :started_at
      t.datetime :ended_at
      t.string :sid
      t.string :error_message

      t.timestamps
    end
  end
end
