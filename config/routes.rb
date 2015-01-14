Rails.application.routes.draw do

  
  resources :shifts
  resources :investment_declarations
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  resources :policies
  
  resources :amzur_events
  get 'amzur_events/show' => 'amzur_events#show'
  
  resources :announcements
   get 'announcements/show' => 'announcements#show'
   
  resources :recruitments  
  get 'recruitments/show' => 'recruitments#show'

  resources :events 
  get 'getAllEmployees' => 'employees#getAllEmployees'
  #get 'holiday_notification' => "events#holiday_notification" 

  #devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   authenticated :user do
    root 'welcome#wall', :as => "authenticated_root"
   end
    root 'welcome#index'
   
   
    devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "omniauth_callbacks"}

  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/users/auth/:provider/callback' => 'omniauth_callbacks#all'
  end
   
   resources :roles do
   member do
      get "/add_employee" => "roles#add_employee"
      post 'update_employee'
    end  
  end

  get '/dashboard' => 'welcome#dashboard'
   get '/departments_list' => "departments#department_index"
   resources :departments do
   resources :holiday_calenders
	 resources :leave_policies
   member do
      get "/add_employee" => "departments#add_employee"
      post 'update_employee'
      get '/employee_leaves' => "departments#employee_leaves"
      get '/leaves' => "departments#leaves"
      get  'assign_appraisal'
      post 'create_appraisal'
    end 
    collection do
				get 'holiday_list'
			end 

  end

  get 'payslips_pdf' => "salaries#payslips_pdf"
   
  resources :designations do 
    member do
      get "/add_employee" => "designations#add_employee"
      post 'update_employee'
    end  
  end
   
   resources :grades do 
    member do
      get "/add_employee" => "grades#add_employee"
      post 'update_employee'
    end  
  end
 
   resources :groups do
     resources :leave_policies
     resources :holiday_calenders
       member do
        get 'add_employee'
        post 'update_add_employee'
        get 'holiday_notification'
       end
			#collection do
				#get 'holiday_list'
			#end
		   
     end
    
    resources :leave_types 
 resources :leave_histories do 
  member do 
    get 'getLeaveForm'
    post 'reject'
  end
 end
get 'reportees_leaves' => "leave_histories#reportees_leaves"
get 'reported_leaves' => "leave_histories#reported_leaves"
get 'reported_employees' => "leave_histories#reported_employees"
get 'applied_leaves' => "leave_histories#applied_leaves"
post 'accept' => "leave_histories#accept"
#post 'reject' => "leave_histories#reject"
#get 'leaves' => "leave_histories#index"
get 'employee_leaves' => "leave_histories#employee_leaves"
get 'inactive_employees' => "employees#inactive_employees"
 resources :employees do
    
		resources :ff_statuses 
    resources :leaves
	  resources :emergency_contacts
	  #resources :statuses do
	  #resources :comments
	  #resources :likes
	  #end
		member do
			get 'exit_form'
			get 'exit_edit_form'
			post 'update_exit_form'
			get 'show_exit'
			get 'profile'
			get 'myprofile'
			get 'attachment_form_new'
			post 'update_attachment'
			get 'attachment_index'
			delete 'attachment_destroy/:attachment_id' => 'employees#attachment_destroy', as: :attachment_destory
			get  'attachment_edit/:attachment_id' => 'employees#attachment_edit', as: :attachment_edit
			patch 'attachment_update/:attachment_id'=> 'employees#attachment_update', as: :attachment_update
			get 'attachment_show'
			post 'attachment_create'
			get 'bankdetails_form'
			get 'bankdetails_show'
			get 'bankdetails_edit'
			post 'bankdetails_create'
			post 'bankdetails_update'	
			
			get 'employee_self_description_show'
			get 'employee_self_description_form'
			patch 'employee_self_description_create'
			post 'change_status'
			
		end
		
   
		
  
  resources :educations do
     collection do
        get 'qualifications'
        post 'new_form'
				
      end
    end
    resources :email_ettiquities
		resources :promotions
		resources :salaries do 
					
					post 'create_allowance'
					get 'edit_allowance'
					post 'update_allowance'
					get 'add_allowance'
					post "/configure" => "salaries#configure_pf"
          resources :allowances
          resources :salaries_allowances do
            collection do
					    get 'edit_allowance'
					    post 'update_allowance'
					    get 'add_allowance' 
            end
          end
     end
         
         
          
       

    resources :experiences
  resources :addresses 
end
# routes for pay roll generation
 get 'payroll' => "payrolls#payroll"
 post 'payrolls' => "payrolls#pay_roll_generation"
 get 'payroll_view' => "payrolls#generated_payroll"
 get 'payroll/:id/edit' => 'payrolls#edit_payroll'
 put 'payroll/:id' => 'payrolls#update_payroll'
 get 'payroll/:id' => 'payrolls#show_payroll'
 get "payrolls/exporting_payslips_excel_sheet"
 get "payrolls/bank_process"
 get 'monthly_payslips' => "payrolls#employee_monthly_payslips"
 get 'monthly_payslip_view/:id' => "payrolls#monthly_payslip_view", as: :individual_payslips
 post 'payrolls/employee_payslips_by_year'
 get "payrolls/get_payroll_years"
          
#-----------------------------------------------------------------------------------------------

  #get 'profile/:id/edit' => "profile#edit" 
 # get 'profile/:id' => "profile#edit",  as: :profile
  get 'new_profile' => "profile#new"

  get 'myprofile' => "employees#myprofile", as: :myprofile

  get 'profile/:id' => "profile#show", as: :profile
  
  
  # route for profile emp view in wall
  get '/employees/:id/profile' => "employees#profile" 
  
  #resources :educations
  
    resources :addresses do
     collection do
      get 'cities'
      get 'states' 
      get 'countries'
      
    end
  end
  
  # routes for indivisual allowances
  
  resources :static_allowances
  resources :allowances
  #resources for static_salaries
  resources :static_salaries
  
  #--------------------------------------
  
  
  # routes for pay slips navigation- priyanka
  resources :company_pay_roll_masters
  #--------------------------------------
   
   
  #rout for job locations
 resources :job_locations 
 
 #route for generic_investment_declarations
 resources :section_declarations
 
 resources :general_investments
 resources :employee_attendence do
  collection do
    get 'show_attendance'
    get 'new_attendence_log'
    post 'upload_file'
    get 'attandence_ws'
    get 'attendence_log_ws'
    get 'emp_show_attendance' => "employee_attendence#emp_show_attendance"
    get 'emp_show_attendance_ws'
  end
 end


  resources :letters , :only => :index do 
    collection do 
      get 'reference_letter'
      get 'address_proof_letter'
      get 'salary_certificate'
    end
  end
  
   get 'reference_notification' => "letters#reference_notification" # email for reference letter
   get 'address_notification' => "letters#address_notification" # email for address 
   get 'salary_notification' => "letters#salary_notification" # email for salary certificate

  #get 'change_designation' => "designations#change_designation"
  
  resources :features , :only => :index do
    
  end
get 'configure' => "features#features_configure"
post 'create_package' => "features#create_package"


  resources :tax_brackets
  resources :tax_exemptions
  


  
  # Routes for apprisal_cycle
  resources :appraisal_cycles
  post "appraisal_cycles/status_update"
   post "appraisal_cycles/appraisal_status_update"
  #routes for goals
   resources :goals
  #routes for review_elements
    resources :review_elements

    
    get 'getEmployees' => 'appraisals#getEmployees'
  # for employee status
  resources :statuses do
     member do
      get "add_comment_form" 
      post "add_like"
      post "remove_like"
    end
     collection do
      post "add_comments"
    end
    resources :comments # for deleting comments
  end

  

  # routes for Album
  resources :albums do
    resources :photos 
    member do
     get "add_more_photos_form"
     get "add_comment"
     post "add_more_photos"
     post "add_like"
     post "remove_like"
    end
    collection do
      post "add_comments"
    end
  end
  
  # routes for Calendar
  #resources :calendars
 
  get '/calendar' => 'calendars#index'
 
  get "/calendars/reporting_manager_calendar" => 'calendars#reporting_manager_calendar'
  get "/calendars/reportees_leaves_calendar" => 'calendars#reportees_leaves_calendar'
  get "/calendars/workgroup_calendar" => 'calendars#workgroup_calendar'
  get "/calendars/workgroup_leaves_calendar" => 'calendars#workgroup_leaves_calendar'
  #get "/calendars/department_calendar" => 'calendars#department_calendar'
  get "/calendars/company_calendar" => 'calendars#company_calendar'
  get "/calendars/company_leaves_calendar" => 'calendars#company_leaves_calendar'
  match '/calendars/department_calendar' => 'calendars#department_calendar', via: [:get,:post]
  match '/calendars/department_leaves_calendar' => 'calendars#department_leaves_calendar', via: [:get,:post]
  
  
  #match '/auto-links' => 'main#auto_links', via: [:get, :post]
  
  resources :projects


  
  resources :tax_forms, :only => :index 

  get "my_tax_from/:assesment_year" => "tax_forms#show", as: :tax_form

 get "/getAllSkills" => "employees#getAllSkills" 
 
  #routes for appraisals
  resources :appraisals
  get "/appraisal_assignment" => "appraisals#assign_appraisal"
  post "appraisals/create_appraisal"
  get "/employee_appraisal_form" => "appraisals#employee_appraisal_form"
  post "appraisals/create_employee_appraisal"
  get "/appraisals_list" => "appraisals#employee_appraisals"
  get "/manager_view/:id" => "appraisals#manager_view"
  post "/manager_feedback/:id" => "appraisals#manager_feedback"
  get "/hr_manager_view/:id" => "appraisals#hr_manager_view"
  get "/my_appraisals" => "appraisals#indivisual_appraisals"
  get "/appraisal_view/:id" => "appraisals#appraisal_view"
  get "/employee_appraisal_view/:id" => "appraisals#employee_appraisal_view"
  get 'assign_employee_appraisals' => "appraisals#assign_employee_appraisals"
  get '/manager_appraisal_view/:id' => "appraisals#manager_appraisal_view"
  get "/reportees" => "appraisals#reportees"
  get '/reportee_appraisals/:id' => "appraisals#reportee_appraisals"
  get "/reportee_appraisal_view/:id" => "appraisals#reportee_appraisal_view"
  get "/reportee_appraisal_edit/:id" => "appraisals#reportee_appraisal_edit"
  post "/reportee_appraisal_update/:id" => "appraisals#reportee_appraisal_update"
 
  # for work groups Author:Vidya Sagar
  resources :workgroups do 
   member do
     get "add_moderator"
     get "add_members"
     post "added_moderators" 
     post "added_members"
     delete "destroy_member/:employee_id" => 'workgroups#destroy_member', as: :destroy_member # for destroying member from work group
     get "get_employees"
    end
  end
  get 'my_workgroups'	=> "employees#my_workgroups"
  #get "/get_employees" => "workgroups#get_employees"
  resources :posts do
    member do
      get "add_comment_form" 
      post "add_like"
      post "remove_like"
    end
    collection do
      post "add_comments"
    end
  end 
  resources :organization
  
  get "welcome/wall" 
  get "welcome/header"
  
  get 'login' => "welcome#login"
  
  #Edit Employee
  
  get "edit_employee_email/:id"  => "employees#edit_email", as:"edit_employee_email"
  put "update_employee_email/:id" =>"employees#update_email", as: "update_employee_email"
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
