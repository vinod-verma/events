class CreateEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :emails do |t|
      t.integer :campaign_id
      t.string :recipient_email
      t.string :recipient_user_id
      t.json :data_field
      t.json :mata_data

      t.timestamps
    end
  end
end
