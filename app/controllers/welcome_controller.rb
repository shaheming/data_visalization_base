class WelcomeController < ApplicationController
  before_action :check_1, :check_2, :only => :test

  def index
    @text = Time.now.to_s + "SHAME"
    logger.info {"=====#{Time.now.to_s}======="}
  end

  def test
    render :json => {msg: "hello word! test  ww"}
    p params
  end

  private

  def check_1
    render :json => {msg: "data less than 1"} if params[:data].to_i <= 1
  end

  def check_2
    render :json => {msg: "data less than 2"} if params[:data].to_i <= 2
  end
end
