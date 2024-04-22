class PeopleController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :validate_user_access, only: [:show]

  def show
    @expenses = UserExpensesService.new(@user).call
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  #Simple authorization so that a user cannot view the details of users outside his connection
  def validate_user_access
    unless current_user.peers.include?(@user)
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end

end
