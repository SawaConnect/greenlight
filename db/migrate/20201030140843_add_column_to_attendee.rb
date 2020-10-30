class AddColumnToAttendee < ActiveRecord::Migration[5.2]
  def change
    add_column :attendees, :activity_score, :integer

  end
end
