module PaymentHelper

	@@appID = 'democreditor01'
	@@appSecret = 'demosecret01'
	@@creditorReference = 'democreditor'

	@@server = 'https://api-sandbox.slimpay.net'

	private
	def self.getToken
		encodedKey = Base64.encode64(@@appID+':'+@@appSecret)
		response = HTTParty.post(@@server+'/oauth/token',
			:body => { 
				:grant_type => "client_credentials",
				:scope => 'api'
             }.to_json,
    		:headers => { 'Accept' => 'application/json', 'Content-Type' => 'application/hal+json', 'Authorization' => 'Basic '+ encodedKey }
    	)
		response
	end

end
