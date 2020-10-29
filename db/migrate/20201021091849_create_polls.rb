class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.text :meeting_id
      t.text :meeting_name
      t.text :internal_id
      t.boolean :published
      t.datetime :start
      t.text :options
      t.text :votes
      t.timestamps
    end
  end
end
