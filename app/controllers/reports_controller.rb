# frozen_string_literal: true

class ReportsController < ApplicationController
  include Recorder
  include Pagy::Backend

  def show
    @meeting = Meeting.find_by(internal_id: params[:id])
    @attendees = Attendee.where(internal_id: params[:id])
    @attendees.each do |attendee|
      average_talk_time = (@attendees.sum(:talk_time).to_f / 60) / @attendees.count.to_f
      activity_point_talk_time = (attendee.talk_time.to_f % 3600 / 60).to_f / average_talk_time

      average_chat = @attendees.sum(:chats).to_f / @attendees.count.to_f
      activity_chat = attendee.chats / average_chat  rescue 0

      average_emojis = @attendees.sum(:emojis).to_f / @attendees.count.to_f
      activity_emoji = attendee.emojis / average_emojis rescue 0

      average_raisehand = @attendees.sum(:raisehand).to_f / @attendees.count.to_f
      activity_raisehand = attendee.raisehand / average_raisehand rescue 0

      average_poll_votes = @attendees.sum(:poll_votes).to_f / @attendees.count.to_f
      activity_poll_votes = attendee.poll_votes / average_poll_votes rescue 0

      enagemanet_score = (activity_point_talk_time.nan? ? 0 :  activity_point_talk_time) + (activity_chat.nan? ? 0 : activity_chat) + (activity_emoji.nan? ? 0 : activity_emoji) + (activity_raisehand.nan? ? 0 : activity_raisehand) + (activity_poll_votes.nan? ? 0 : activity_poll_votes)
      attendee.activity_score = enagemanet_score.round(1)
      attendee.save
    end
    @attendees = @attendees.order(activity_score: :desc)
    @polls = Poll.where(internal_id: params[:id])
  end

  def attendee
    @meeting = Meeting.find_by(id: params[:meeting_id])
    @attendees = Attendee.where(internal_id: @meeting.internal_id).where.not(moderator: true)
    @attendee = Attendee.find_by(id: params[:id])
    render layout: false
  end
end
