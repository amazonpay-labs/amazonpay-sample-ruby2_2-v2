#!/usr/bin/env ruby

open __dir__ + '/keyinfo.rb', 'w' do |f|
    f.write <<~EOS
        module KeyInfo
            MERCHANT_ID = 'XXXXXXXXXXXX'
            PUBLIC_KEY_ID = 'XXXXXXXXXXXXXXXXXXXXXXXXX'
            STORE_ID = 'amzn1.application-oa2-client.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
            PRIVATE_KEY_PATH = __dir__ + '/privateKey.pem'
        end
    EOS
end

open __dir__ + '/privateKey.pem', 'w' do |f|
    f.write <<~FINISH
        -----BEGIN RSA PRIVATE KEY-----
        PASTE YOUR PRIVATE KEY HERE!
        -----END RSA PRIVATE KEY-----
    FINISH
end