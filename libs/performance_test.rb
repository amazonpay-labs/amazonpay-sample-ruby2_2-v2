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
puts "ボタンシグニチャ計算 500回実行時時間: #{result}秒, 1回平均: #{result / 500}秒"

result = Benchmark.realtime do
    500.times do |i|
        client.generate_button_signature("AMZN-PAY-RSASSA-PSS\nc5c55b2d523738b72c0b96f6d5e0d712d9496573490125b191eeb6840c052f" + i.to_s)
    end
end
puts "リクエストシグニチャ計算 500回実行時時間: #{result}秒, 1回平均: #{result / 500}秒"


=begin
% ruby performance_test.rb
ボタンシグニチャ計算 500回実行時時間: 6.202556999982335秒, 1回平均: 0.012405113999964669秒
リクエストシグニチャ計算 500回実行時時間: 6.289648000034504秒, 1回平均: 0.012579296000069008秒
=end
