class HomeController < ApplicationController
  def index    
    redirect_to "/c42/wrest" if user_signed_in?
  end
end
