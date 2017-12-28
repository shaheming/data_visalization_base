class WelcomeController < ApplicationController
  def index
    @text = Time.now.to_s + "SHAME"
    logger.info {"=====#{Time.now.to_s}======="}
  end
end
