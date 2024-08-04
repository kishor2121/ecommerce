class Admin::SessionsController < Devise::SessionsController
  after_action :after_sign_out_path, only: :destroy

  protected

  # Redirect to root path after sign out
  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "Successfully signed out."
    root_path # Redirect to root_path after sign out
  end
end
