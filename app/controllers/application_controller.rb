class ApplicationController < ActionController::Base
    require 'pagy/extras/bootstrap'
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        apartments_path
    end

    def after_sign_out_path_for(resource)
        new_client_session_path
    end

    def authorize_request(kind = nil)
        unless kind.include?(current_client.role)
            redirect_to apartments_path, notice: "No tienes permiso para hacer esto. Consulta a un administrador."
        end
    end

    Pagy::DEFAULT[:items] = 6
    include Pagy::Backend

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :username, :phone, :role])
        devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :username, :phone, :role])
    end


end
