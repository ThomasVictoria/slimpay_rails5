module PaymentHelper

	@appID = 'hbs0px5mh3xqbx2'
	@appSecret = 'm4r7dxW6TdGqFvza~e~CrPvtqNc9'
	@creditorReference = 'hbs0px5mh3xqbx2'

	@server = 'https://api-sandbox.slimpay.net'

	private

	def self.getToken
		encodedKey = Base64.encode64(@appID+':'+@appSecret)
		authorization = 'Basic ' + encodedKey
		url = @server + '/oauth/token'

		return HTTParty.post(url,
			body: {
				:grant_type => 'client_credentials&scope=api'
			}.to_json,
			headers: {
				'Accept' => 'application/json',
				'Content-Type' => 'application/hal+json',
				'Authorization' => authorization
			}
		)
	end

end
