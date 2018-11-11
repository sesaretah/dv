class PasswordsController < Devise::PasswordsController
  def create
    @user = User.where(email: params[:user][:email]).first
    @user.reset_password_token = SecureRandom.hex(30)
    if @user.save
      system("node #{Rails.root.join('lib', 'nodemailer')}/mailer.js --to #{@user.id} --mail_type change_password")
    end
  end

  def update
    @user = User.where(reset_password_token: params[:user][:reset_password_token]).first

    respond_to do |format|
      if @user.reset_password(params[:user][:password],params[:user][:password_confirmation])
        format.html { redirect_to '/', notice: "" }
        format.json { render :show }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
