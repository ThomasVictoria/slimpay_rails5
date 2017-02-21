class PaymentController < ApplicationController

  def yolo

	response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')

	puts response

  	@yolo = "The YOLO is real"
  end

end
