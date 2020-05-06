# frozen_string_literal: true

require 'rubygems'
require 'net/https'
require 'uri'
require 'json'

class TextlocalClient
  ENDPOINT = 'https://api.textlocal.in/send/?'
  TL_APIKEY = 'ZncNHRxnLGs-vao3ACcWoPwbSGYol4M9opZDwD3dhf' # Get the key from TextLocal.in

  def self.send_sms(mobile_number, message)
    uri = URI.parse(ENDPOINT)
    http = Net::HTTP.start(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    res = Net::HTTP.post_form(
      uri,
      apikey: TL_APIKEY,
      message: message,
      sender: ENV['SMS_SENDER'], # This is configurable sender-code from TextLocal if I remember right.
      numbers: mobile_number
    )

    response = JSON.parse(res.body)
    # puts response["status"]
    response['status']
  end

  def self.send_otp(mobile_number, otp)
    if Rails.env.production?
      send_sms("91#{mobile_number}", "Your verification code is #{otp}")
    else
      send_sms("91#{mobile_number}", "Your verification code is #{otp}")
    end
  end
end
