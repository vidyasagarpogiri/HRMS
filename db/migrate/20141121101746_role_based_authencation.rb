class RoleBasedAuthencation < ActiveRecord::Migration
 def change
      Feature.destroy_all
      puts "Creating Feature Table"
      Rails.application.eager_load!
      all_controllers = ApplicationController.descendants
      all_controllers.each do |controller|
        controller.action_methods.each do |action|
          Feature.create(controller: controller, action: action)
        end
      end
      puts "completed Feature Table"
  end
end
