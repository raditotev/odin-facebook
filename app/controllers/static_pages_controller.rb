class StaticPagesController < ApplicationController
  def index
    @users = User.all
  end
end
