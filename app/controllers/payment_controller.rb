class PaymentController < ApplicationController

  def yolo
  	@token = PaymentHelper.getToken
  end

end
