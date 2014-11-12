class AddPackages < ActiveRecord::Migration
  def change
    Role.all.each do |role|
      ["monthly_payslip_view", "employee_monthly_payslips", "employee_payslips_by_year"].each do |action|
        feature_id = Feature.find_by_action(action).id
        Package.create(role_id: role.id, feature_id: feature_id )
      end
    end
   
  end
end
