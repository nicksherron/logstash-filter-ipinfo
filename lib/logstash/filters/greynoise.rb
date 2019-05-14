# encoding: utf-8
require "logstash/filters/base"
require "json"
require "logstash/namespace"
require 'faraday'


# This  filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Ipinfo < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
   #  filter {
   #   ipinfo {
   #     ip => "ip"
   #   }
   #  }

  config_name "ipinfo"

  # Replace the message with this value.

  config :ip, :validate => :string, :required => true
  config :token, :validate => :string, :required => false
  config :target, :validate => :string, :default => "ipinfo"



  public
  def register
  end # def register

  public
  def filter(event)

    # check if api token exists and has len of 10 or more to prevent forbidden response
    if @token.length >= 10
      url = "https://ipinfo.io/" + event.sprintf(ip) + "/json?token=" + event.sprintf(token)
      uri = URI.parse(URI.encode(url.strip))
      response = Faraday.get(uri, nil, 'User-Agent' => 'logstash-filter-ipinfo')
    # if no token then use free api
    else
      url = "https://ipinfo.io/" + event.sprintf(ip) + "/json"
      uri = URI.parse(URI.encode(url.strip))
      response = Faraday.get(uri, nil, 'User-Agent' => 'logstash-filter-ipinfo')

    end

    result = JSON.parse(response.body)

    event.set(@target, result)
    # filter_matched should go in the last line of our successful code
    filter_matched(event)

  end # def filter
end # class LogStash::Filters::Ipinfo

