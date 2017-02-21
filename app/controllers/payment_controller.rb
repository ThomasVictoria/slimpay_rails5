class PaymentController < ApplicationController

  def yolo

  	puts PaymentHelper.getToken

  	@yolo = 'The YOLO is real'
  end

end
