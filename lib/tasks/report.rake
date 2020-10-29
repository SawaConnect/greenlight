# frozen_string_literal: true

namespace :report do
  desc 'Report of meeting'
  task meeting_report: :environment do
    @events = Dir.glob '/var/bigbluebutton/events/**/events.xml'
    # @events = Dir.glob 'presentation/**/events.xml'
    @header1 = ['SI No', 'Session Id/Name', 'Session Start date-time',
                'Session End date-time', 'total unique participants']
    @header2 = ['SI No', 'Session Id/Name', 'User id/name',
                'First Join Date-time', 'Last Out Date-Time']
    csv_summary
    csv_detailed
  end
end

def csv_summary
  @events.each do |event_file|
    internal_id = event_file.split('/')[4]
    meeting = Meeting.where(internal_id: internal_id)
    next if meeting.length.positive?

    recording = BBBEvents.parse(event_file)
    puts "=============================="
    p recording.meeting_id
    room = Room.find_by(bbb_id: recording.meeting_id)
    next if room.blank?

    Meeting.create(room_id: room.id, meeting_id: recording.meeting_id.gsub('"', ' '),
                   meeting_name: recording.metadata['meetingName'].gsub('"', ' '),
                   internal_id: internal_id, start: recording.start, finish: recording.finish,
                   duration: recording.duration, attendees: recording.attendees.length,
                   moderators: recording.moderators.length, viewers: recording.viewers.length,
                   polls: recording.polls.length, published_polls: recording.published_polls.length,
                   unpublished_polls: recording.unpublished_polls.length, files: recording.files.length)
  end
end

def csv_detailed
  @events.each do |event_file|
    internal_id = event_file.split('/')[4]
    attendee_data = Attendee.where(internal_id: internal_id)
    poll_data = Poll.where(internal_id: internal_id)
    recording = BBBEvents.parse(event_file)
    room = Room.find_by(bbb_id: recording.meeting_id)
    next if room.blank?

    unless attendee_data.length.positive?
      recording.attendees.each do |attendee|
        Attendee.create(meeting_id: recording.meeting_id.gsub('"', ' '),
                        meeting_name: recording.metadata['meetingName'].gsub('"', ' '),
                        internal_id: internal_id, attendee_id: attendee.id.gsub('"', ' '),
                        name: attendee.name.gsub('"', ' '), moderator: attendee.moderator?, duration: attendee.duration,
                        joined: attendee.joined, left: attendee.left, joins: attendee.joins.length,
                        leaves: attendee.leaves.length, chats: attendee.engagement[:chats],
                        talks: attendee.engagement[:talks], raisehand: attendee.engagement[:raisehand],
                        emojis: attendee.engagement[:emojis], poll_votes: attendee.engagement[:poll_votes],
                        talk_time: attendee.engagement[:talk_time])
      end
    end
    unless poll_data.length.positive?
      recording.polls.each do |poll|
        Poll.create(meeting_id: recording.meeting_id.gsub('"', ' '),
                    meeting_name: recording.metadata['meetingName'].gsub('"', ' '),
                    internal_id: internal_id, published: poll.published?, start: poll.start,
                    options: poll.options.length, votes: poll.votes.length)
      end
    end
  end
end
