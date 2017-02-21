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
			headers: {
				'Accept' => 'application/json',
				'Content-Type' => 'application/x-www-form-urlencoded',
				'Authorization' => authorization
			},
			body: {
				:grant_type => 'client_credentials',
				:scope => 'api'
			}.to_query
		)
	end

end
