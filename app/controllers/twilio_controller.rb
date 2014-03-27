require 'twilio-ruby'
 
class TwilioController < ApplicationController
  include Webhookable
 
  after_filter :set_header
 
  def text
    response = Twilio::TwiML::Response.new do |r|
      r.message 'Baseball is awesome'
    end
 
    render_twiml response
  end
end