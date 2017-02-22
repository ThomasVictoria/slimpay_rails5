class PaymentController < ApplicationController

  def yolo
  	@token = PaymentHelper.get_token
    # @decoded_token = JWT.decode(@token['access_token'], "m4r7dxW6TdGqFvza~e~CrPvtqNc9", true)
    response = PaymentHelper.get_links(@token["access_token"])
    @links = JSON.parse(response.body)
    @order = PaymentHelper.create_order(@token["access_token"], @links)
    @user = PaymentHelper.checkUser(@token['access_token'])
    puts @user
    puts '-------------------------------------------------------------------'
    puts @order
  end

end
