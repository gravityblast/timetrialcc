class UsersController < ApplicationController
  def settings
  end

  def destroy
    current_user.destroy!
    flash_message :success, 'You account has been permanently deleted.'
    redirect_to root_path
  end
end
