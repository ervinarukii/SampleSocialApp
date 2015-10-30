class HomeController < ApplicationController
  
  def index
    @status = Status.new
    @activities = Activity.order(created_at: :desc).page(params[:page]).per(10)
  end

end
