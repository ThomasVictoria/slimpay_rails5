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
      	started: true,
        creditor: {
          reference: @creditor_reference
        },
        subscriber: {
        	reference: 'user1'
        },
        items: [
        	{
        		type: "signMandate",
        		autoGenReference: true,
        		mandate: {
        			signatory: {
        				billingAddress: {
        					street1: "9 place",
        					street2: "Jean Jaurès",
        					city: 'Paris',
        					postalCode: '93100',
        					country: 'FR'
        				},
        				honorificPrefix: 'Mr',
        				givenName: 'Doe',
        				familyName: 'John',
	                    email: "change.me@slimpay.com",
	                    telephone: '+33631772046'
        			},
        			standard: 'SEPA'
        		}
        	},
        	{
            type: "recurrentDirectDebit",
            recurrentDirectDebit: {
                amount: "192",
                label: "This is my Recurrent Direct Debit",
                frequency: "monthly",
                maxSddNumber: "5",
                activated: true,
                dateFrom: "2017-11-04T13:11:52.900+0000"
            }
        }
        ]
      }.to_json
    )
  end

  def self.checkUser(token)
  	authorization = 'Bearer ' + token
  	HTTParty.get('https://api-sandbox.slimpay.net/orders/0aba5db6-f904-11e6-8d7f-000000000000',
		headers: {
	        'Accept' => 'application/hal+json; profile="https://api.slimpay.net/alps/v1"',
	        'Content-Type' => 'application/json',
	        'Authorization' => authorization
     		}
  		)
  end

end
