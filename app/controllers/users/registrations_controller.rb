# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
   def create
      super
=begin
      if params[:active]
        user = User.find_by_email(params[:user][:email])
        if !user.nil?
          company = user.build_company(description: params[:description], 
                                       phone: params[:phone],
                                       headquarters: params[:headquarters],
                                       careers_advertisement: params[:careers_advertisement])
          if !company.save
            user.destroy
          end
        end
      end
=end
      user = User.find_by_email(params[:user][:email])
      if !user.nil? && params[:active]
        @company = user.build_company(description: params[:user][:company][:description], 
                                      phone: params[:user][:company][:phone],
                                      headquarters: params[:user][:company][:headquarters],
                                      careers_advertisement: params[:user][:company][:careers_advertisement])
        @company.save
      end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name,
        company_attributes: [:id, :description, :phone, 
          :headquarters, :careers_advertisement, :active]])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:name,
        company_attributes: [:id, :description, :phone, 
          :headquarters, :careers_advertisement, :active]])
   end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
      super(resource)
   end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
