module PaymentHelper

	@app_id = 'hbs0px5mh3xqbx2'
	@app_secret = 'm4r7dxW6TdGqFvza~e~CrPvtqNc9'
	@creditor_reference = 'hbs0px5mh3xqbx2'
  @token = String.new
	@server = 'https://api-sandbox.slimpay.net'

  def self.get_token
 		encoded_key = Base64.encode64(@app_id+':'+@app_secret)
		authorization = 'Basic ' + encoded_key
		url = @server + '/oauth/token'

		HTTParty.post(url,
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

  def self.get_links(token)
    authorization = 'Bearer ' + token
    order = HTTParty.get('https://api-sandbox.slimpay.net/',
      headers: {
				'Accept' => 'application/hal+json; profile="https://api.slimpay.net/alps/v1"',
				'Content-Type' => 'application/json',
				'Authorization' => authorization
      }
    )
	end

  def self.create_order(token, links)
    authorization = 'Bearer ' + token
    order = HTTParty.post(links["_links"]['https://api.slimpay.net/alps#create-orders']["href"],
      headers: {
        'Accept' => 'application/hal+json; profile="https://api.slimpay.net/alps/v1"',
        'Content-Type' => 'application/json',
        'Authorization' => authorization
      },
      body: {
        creditor: {
          reference: @creditor_reference
        }
      }.to_json
    )
  end

end
