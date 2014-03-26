require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  def text
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Baseball is fun" #put something here

    end

    render_twiml twiml
  end

  
end