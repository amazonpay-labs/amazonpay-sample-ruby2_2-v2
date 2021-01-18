
=begin
# Performed on Macbook Pro 16 (2019, CPU: 2.3GHz 8-Core Intel Core i9, Memory: 32GB, OpenSSL: 2.8.3)
# CPU Load: increased about 4% during this performance test
# Memory: Almost no impact
# Result: Button signature calculation: about 12 ms, Request signature calculation: about 12 ms

# Log:
% ruby performance_test.rb 
The elapled time for calculating button signature 500 times: 5.840118999942206 seconds, average: 0.011680237999884411 seconds
The elapled time for calculating request signature 500 times: 5.933503000065684 seconds, average: 0.011867006000131368 seconds
=end

require '../keys/keyinfo'
require './signature'

require 'securerandom'
require 'benchmark'

config = {
    region: 'jp',
    public_key_id: KeyInfo::PUBLIC_KEY_ID,
    private_key_path: KeyInfo::PRIVATE_KEY_PATH,
    sandbox: true
}

client = AmazonPayClient.new config

result = Benchmark.realtime do
    500.times do |i|
        client.generate_button_signature("{\"webCheckoutDetails\":{\"checkoutReviewReturnUrl\":\"http://localhost:4567/review/#{i.to_s}\"},\"storeId\":\"amzn1.application-oa2-client.242a859efb5f47f09847f3f0aebd50ca\"}")
    end
end
puts "The elapled time for calculating button signature 500 times: #{result} seconds, average: #{result / 500} seconds"

result = Benchmark.realtime do
    500.times do |i|
        client.generate_button_signature("AMZN-PAY-RSASSA-PSS\nc5c55b2d523738b72c0b96f6d5e0d712d9496573490125b191eeb6840c052f" + i.to_s)
    end
end
puts "The elapled time for calculating request signature 500 times: #{result} seconds, average: #{result / 500} seconds"

