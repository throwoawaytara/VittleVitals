require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  def text
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message #put something here

    end

    twiml.text
  end

  
end