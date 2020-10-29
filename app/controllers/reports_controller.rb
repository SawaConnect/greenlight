# frozen_string_literal: true

class ReportsController < ApplicationController

  def show
    @meeting = Meeting.find_by(internal_id: params[:id])
    @attendees = Attendee.where(internal_id: params[:id])
    @polls = Poll.where(internal_id: params[:id])
  end

  def attendee
    @meeting = Meeting.find_by(id: params[:meeting_id])
    @attendees = Attendee.where(internal_id: @meeting.internal_id).where.not(moderator: true)
    @attendee = Attendee.find_by(id: params[:id])
    render layout: false
  end
end
