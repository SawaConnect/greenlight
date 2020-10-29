class CreateAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
      t.text :meeting_id
      t.text :meeting_name
      t.text :internal_id
      t.text :attendee_id
      t.text :name
      t.boolean :moderator
      t.text :duration
      t.datetime :joined
      t.datetime :left
      t.datetime :joins
      t.datetime :leaves
      t.integer :chats
      t.integer :talks
      t.integer :raisehand
      t.integer :emojis
      t.integer :poll_votes
      t.integer :talk_time
      t.timestamps
    end
  end
end
