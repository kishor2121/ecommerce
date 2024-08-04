class AdminController < ApplicationController
    before_action :check_admin_priv
    def show 
    end

    private
    def check_admin_priv
        if !current_admin
            redirect_ root_path
        end
        
    end

end
