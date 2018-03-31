class WelcomeController < ApplicationController

  def index
    @text = Time.now.to_s + "SHAME"
  end

end
