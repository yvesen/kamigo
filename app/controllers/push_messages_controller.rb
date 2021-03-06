require 'line/bot'
class PushMessagesController < ApplicationController
	before_action :authenticate_user!

	# GET /push_messages/new
  def new
  end

  # POST /push_messages
  def create
  	text = params[:text]
  	Channel.all.each do |channel|
      push_to_line(channel.channel_id, text)
    end
    redirect_to '/push_messages/new'
  end

  # 傳送訊息到 line
  def push_to_line(channel_id, text)
    return nil if channel_id.nil? or text.nil?
    
    # 設定回覆訊息
    message = {
      type: 'text',
      text: text
    } 

    # 傳送訊息
    line.push_message(channel_id, message)
  end

  # Line Bot API 物件初始化
  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = 'cc045385cef60f08f97c691195f41270'
      config.channel_token = 'qpypOGdgP+OaFoUf32PMi9swYJqHXeIh3To/wJwm6C8Su0fjMIR4LGTex7SKWJC9JkSCf7nwC4+kmuoRJShnXO17Guz21dk/oEoN72njzrPQa/pprsa8yfw9Z+DEifJ90c6UZw1hSlGNeH5Tcr/TcAdB04t89/1O/w1cDnyilFU='
    }
  end


end
