# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/ipinfo"

describe LogStash::Filters::Ipinfo do

  describe "defaults" do
    let(:config) do <<-CONFIG
      filter {
        ipinfo {
          ip => "ip"
        }
      }
    CONFIG
    # end

    sample("ip" => "8.8.8.8") do
      insist { subject }.include?("ipinfo")

      expected_fields = %w(ipinfo.ip )
      expected_fields.each do |f|
        insist { subject.get("ipinfo") }.include?(f)
      end
    end
    end
  end
end
#
#
#     sample("message" => "some text") do
#       expect(subject).to include("message")
#       expect(subject.get('message')).to eq('Hello World')
#     end
#   end
# end
