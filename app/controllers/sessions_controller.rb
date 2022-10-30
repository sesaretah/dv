class SessionsController < Devise::SessionsController
  def create
    super do |user|
      assign_start_role(user)
    end
  end

  def cas_login
    redirect_to "https://auth.ut.ac.ir:8443/cas/login?service=https%3A%2F%2Fdivan.ut.ac.ir%2Fusers%2Fservice"
  end

  def destroy
    redirect_to "https://my1.ut.ac.ir/c/portal/logout?service=https://divan.ut.ac.ir/"
  end




end
