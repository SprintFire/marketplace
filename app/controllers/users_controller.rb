class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:success] = "Your account has been successfully updated!"
      render 'edit'
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
