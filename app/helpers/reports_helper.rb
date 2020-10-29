# frozen_string_literal: true

# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
#
# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

module ReportsHelper
  # Helper for converting BigBlueButton dates into the desired format.
  def calculation_for_attendee(attendee, attendees)
    hash = {}
    average_talk_time = (attendees.sum(:talk_time).to_f / 60) / attendees.count.to_f
    activity_point_talk_time = (attendee.talk_time.to_f % 3600 / 60).to_f / average_talk_time

    average_chat = attendees.sum(:chats).to_f / attendees.count.to_f
    activity_chat = attendee.chats / average_chat  rescue 0

    average_emojis = attendees.sum(:emojis).to_f / attendees.count.to_f
    activity_emoji = attendee.emojis / average_emojis rescue 0

    average_raisehand = attendees.sum(:raisehand).to_f / attendees.count.to_f
    activity_raisehand = attendee.raisehand / average_raisehand rescue 0

    average_poll_votes = attendees.sum(:poll_votes).to_f / attendees.count.to_f
    activity_poll_votes = attendee.poll_votes / average_poll_votes rescue 0

    enagemanet_score = (activity_point_talk_time.nan? ? 0 :  activity_point_talk_time) + (activity_chat.nan? ? 0 : activity_chat) + (activity_emoji.nan? ? 0 : activity_emoji) + (activity_raisehand.nan? ? 0 : activity_raisehand) + (activity_poll_votes.nan? ? 0 : activity_poll_votes)

    hash['average_talk_time'] = average_talk_time
    hash['activity_point_talk_time'] = activity_point_talk_time
    hash['average_chat'] = average_chat
    hash['activity_chat'] = activity_chat
    hash['average_emojis'] = average_emojis
    hash['activity_emoji'] = activity_emoji
    hash['average_raisehand'] = average_raisehand
    hash['activity_raisehand'] = activity_raisehand
    hash['average_poll_votes'] = average_poll_votes
    hash['activity_poll_votes'] = activity_poll_votes
    hash['enagemanet_score'] = enagemanet_score
    hash
  end

end
