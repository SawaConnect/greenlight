class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :room, foreign_key: true
      t.text :meeting_id
      t.text :meeting_name
      t.text :internal_id
      t.datetime :start
      t.datetime :finish
      t.text :duration
      t.integer :attendees
      t.integer :moderators
      t.integer :viewers
      t.integer :polls
      t.integer :published_polls
      t.integer :unpublished_polls
      t.integer :files
      t.timestamps
    end
  end
end
