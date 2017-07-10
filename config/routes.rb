Rails.application.routes.draw do

  resources :events
  get 'getAllEmployees' => 'employees#getAllEmployees'  

  #devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   authenticated :user do
    root 'employees#index', :as => "authenticated_root"
   end
    root 'welcome#index' # root of the application
   
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
 
get 'reported_leaves' => "leave_histories#reported_leaves"
get 'reported_employees' => "leave_histories#reported_employees"
get 'applied_leaves' => "leave_histories#applied_leaves"
post 'accept' => "leave_histories#accept"
#post 'reject' => "leave_histories#reject"
#get 'leaves' => "leave_histories#index"
#get 'employee_leaves' => "departments#employee_leaves"
 resources :employees do
		resources :ff_statuses 
    resources :leaves
	post "/configure" => "salaries#configure_pf"
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
					
          resources :allowances
          resources :insentives
          resources :salary_increments
      end
    resources :experiences
  resources :addresses
end

  #get 'profile/:id/edit' => "profile#edit" 
  get 'profile/:id' => "profile#edit",  as: :profile
  get 'new_profile' => "profile#edit"

  get 'myprofile' => "employees#myprofile", as: :myprofile
  
  #resources :educations
  
    resources :addresses do
     collection do
      get 'cities'
      get 'states' 
      get 'countries'
      
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
