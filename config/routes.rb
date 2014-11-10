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
  get 'holiday_notification' => "events#holiday_notification" 

  #devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   authenticated :user do
    root 'welcome#dashboard', :as => "authenticated_root"
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
       resources :holiday_calenders
       member do
        get 'add_employee'
        post 'update_add_employee'
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
					get 'configure_allowance'
					post 'create_allowance'
					get 'edit_allowance'
					post 'update_allowance'
					get 'add_allowance'
					post "/configure" => "salaries#configure_pf"
          resources :allowances
          resources :insentives
          resources :salary_increments
      end
    resources :experiences
  resources :addresses 
end



  #get 'profile/:id/edit' => "profile#edit" 
 # get 'profile/:id' => "profile#edit",  as: :profile
  get 'new_profile' => "profile#new"

  get 'myprofile' => "employees#myprofile", as: :myprofile

  get 'profile/:id' => "profile#show", as: :profile
  
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
  

  # routes for pay slips generation page- sekhar
  post 'payslips' => "salaries#pay_slips_generation"
  get 'payslips_view' => "salaries#generated_payslips"
  #get 'payslip_form' => "salaries#edit_payslip"
  get 'payslip/:id/edit' => 'salaries#edit_payslip'
  put 'payslip/:id' => 'salaries#update_payslip'
  get 'payslip/:id' => 'salaries#show_payslip'
  #post 'payslips_monthly_view' => "salaries#monthly_payslips"
  get 'salaries/payslips_list'
  get 'monthly_payslips' => "salaries#employee_monthly_payslips"
  get 'monthly_payslip_view/:id' => "salaries#monthly_payslip_view", as: :individual_payslips
  post 'salaries/employee_payslips_by_year'
  get "salaries/exporting_payslips_excel_sheet"
  get "salaries/get_payroll_years"
  get "salaries/bank_process"
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

  #get 'change_designation' => "designations#change_designation"
  

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
