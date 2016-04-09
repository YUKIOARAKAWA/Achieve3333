class Users::RegistrationsController < Devise::RegistrationsController

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end


  def update
    @user = User.find(current_user.id)
    if @user.provider == 'facebook' || @user.provider == 'twitter'

      if @user.update_without_current_password(users_params)
        sign_in @user, bypass: true
        set_flash_message :notice, :updated
        redirect_to after_update_path_for(@user)
      else
        render 'edit'
      end
    else
      if update_resource(resource, users_params)
        sign_in @user, bypass: true
        set_flash_message :notice, :updated
        redirect_to after_update_path_for(@user)
      else
        render 'edit'
      end
    end
  end


    private
  def users_params
    params.require(:user).permit(:email,:name,:password,:password_confirmation,:current_password,:image_url)
  end

end
