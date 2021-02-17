class ChatroomsController < ApplicationController
  before_action :required_user

  def show
    @message = Message.new
    @messages = Message.most_recent
  end

end