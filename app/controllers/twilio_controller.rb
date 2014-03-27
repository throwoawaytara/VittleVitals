require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  def text
    email = params[:Body].downcase
    user = User.find_by(email: email)
    if user
      message = user.grocery_list.ingredients.map(&:name).join("\n")
    else
      message = "That email was not recognized please try again"
    end

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message(message) #put something here

    end

    render_twiml twiml
  end

end