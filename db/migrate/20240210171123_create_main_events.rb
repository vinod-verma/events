class CreateMainEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :main_events do |t|
      t.string :email
      t.string :event_name
      t.json :data_field
      t.string :type
      t.string :user_id
      t.integer :message_id
      t.integer :template_id
      t.integer :campaign_id
      t.integer :created_by

      t.timestamps
    end
  end
end
