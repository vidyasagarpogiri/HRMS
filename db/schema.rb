# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141126112846) do

  create_table "addresses", force: true do |t|
    t.text     "line1"
    t.text     "line"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.integer  "employee_id"
    t.boolean  "address_type", default: false
    t.boolean  "is_permanent"
  end

  create_table "albums", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "allowances", force: true do |t|
    t.string   "allowance_name"
    t.float    "value",           limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "allowance_value", limit: 24
    t.integer  "salary_id"
    t.boolean  "is_deductable",              default: false
    t.integer  "payslip_id"
    t.float    "total_value",     limit: 24
  end

  create_table "amzur_events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "held_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appraisal_cycles", force: true do |t|
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "period"
    t.date     "employee_dead_line"
    t.date     "manager_dead_line"
    t.date     "discussion_dead_line"
    t.string   "status"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appraisals", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "review_period"
    t.string   "over_all_rating"
    t.integer  "manager_id"
    t.integer  "employee_id"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blood_groups", force: true do |t|
    t.string   "blood_group_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

  create_table "company_pay_roll_masters", force: true do |t|
    t.string   "month"
    t.integer  "year"
    t.string   "status"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_netpay", limit: 24
    t.float    "total_tds",    limit: 24
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "departments", force: true do |t|
    t.string   "department_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "designation_name"
    t.integer  "department_id"
  end

  create_table "education_qualifications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "education_id"
    t.integer  "qualification_id"
  end

  add_index "education_qualifications", ["education_id"], name: "index_education_qualifications_on_education_id", using: :btree
  add_index "education_qualifications", ["qualification_id"], name: "index_education_qualifications_on_qualification_id", using: :btree

  create_table "educations", force: true do |t|
    t.string   "specilization"
    t.string   "institute"
    t.string   "year_of_admission"
    t.string   "year_of_pass"
    t.float    "cgpa_percentage",   limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "Employee_id"
  end

  add_index "educations", ["Employee_id"], name: "index_educations_on_Employee_id", using: :btree

  create_table "email_ettiquities", force: true do |t|
    t.text     "ettiquite"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
    t.string   "dateofsending"
  end

  add_index "email_ettiquities", ["employee_id"], name: "index_email_ettiquities_on_employee_id", using: :btree

  create_table "emergency_contacts", force: true do |t|
    t.string   "name"
    t.string   "relation"
    t.string   "mobile1"
    t.string   "mobile2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

  create_table "employee_attachments", force: true do |t|
    t.integer  "employee_id"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_name"
  end

  create_table "employee_attendence_log_files", force: true do |t|
    t.string   "log_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_attendence_logs", force: true do |t|
    t.integer  "employee_attendence_id"
    t.datetime "time"
    t.boolean  "in_out"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "devise_id"
    t.integer  "employee_id"
  end

  create_table "employee_attendences", force: true do |t|
    t.integer  "employee_id"
    t.date     "log_date"
    t.boolean  "is_present"
    t.float    "total_working_hours", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "employee_skills", force: true do |t|
    t.integer  "skill_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "employee_id"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "date_of_birth"
    t.string   "gender"
    t.string   "marital_status"
    t.float    "total_experience",     limit: 24
    t.boolean  "status",                          default: false
    t.string   "mobile_number"
    t.string   "father_name"
    t.string   "pan"
    t.string   "date_of_confirmation"
    t.string   "date_of_join"
    t.text     "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.integer  "blood_group_id"
    t.integer  "ff_status_id"
    t.integer  "grade_id"
    t.integer  "role_id"
    t.integer  "job_location_id"
    t.integer  "user_id"
    t.integer  "salary_id"
    t.string   "avatar"
    t.string   "alternate_email"
    t.integer  "designation_id"
    t.string   "bank_name"
    t.string   "branch_name"
    t.string   "account_number"
    t.string   "employment_status"
    t.string   "PFAccountNumber"
    t.integer  "shift_id"
    t.string   "devise_id"
    t.integer  "group_id"
    t.text     "self_description"
    t.text     "interests"
  end

  add_index "employees", ["blood_group_id"], name: "index_employees_on_blood_group_id", using: :btree
  add_index "employees", ["department_id"], name: "index_employees_on_department_id", using: :btree
  add_index "employees", ["ff_status_id"], name: "index_employees_on_ff_status_id", using: :btree
  add_index "employees", ["grade_id"], name: "index_employees_on_grade_id", using: :btree
  add_index "employees", ["job_location_id"], name: "index_employees_on_job_location_id", using: :btree
  add_index "employees", ["role_id"], name: "index_employees_on_role_id", using: :btree
  add_index "employees", ["salary_id"], name: "index_employees_on_salary_id", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "event_name"
    t.string   "event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: true do |t|
    t.string   "previous_company"
    t.string   "last_designation"
    t.string   "from_date"
    t.string   "to_date"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: true do |t|
    t.string   "controller"
    t.string   "action"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ff_statuses", force: true do |t|
    t.string   "status_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date_of_exit"
    t.string   "interview_status"
    t.text     "summary"
  end

  create_table "general_investments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "section_declaration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "designation_id"
  end

  create_table "groups", force: true do |t|
    t.string   "group_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holiday_calenders", force: true do |t|
    t.boolean  "mandatory_or_optional"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "event_id"
    t.integer  "department_id"
  end

  create_table "insentives", force: true do |t|
    t.string   "insentive_type"
    t.float    "value",          limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salary_id"
  end

  add_index "insentives", ["salary_id"], name: "index_insentives_on_salary_id", using: :btree

  create_table "investment_declarations", force: true do |t|
    t.integer  "general_investment_id"
    t.float    "yearly_value",          limit: 24
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_locations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
  end

  add_index "job_locations", ["address_id"], name: "index_job_locations_on_address_id", using: :btree

  create_table "leave_histories", force: true do |t|
    t.string   "from_date"
    t.string   "to_date"
    t.text     "reason"
    t.text     "feedback"
    t.integer  "leave_type_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "subject"
    t.boolean  "is_halfday",               default: false
    t.float    "days",          limit: 24
    t.string   "section"
  end

  create_table "leave_policies", force: true do |t|
    t.float    "pl_this_year",                  limit: 24
    t.float    "eligible_carry_forward_leaves", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.integer  "group_id"
  end

  create_table "leave_types", force: true do |t|
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaves", force: true do |t|
    t.float    "pl_carry_forward_prev_year", limit: 24
    t.float    "pl_applied",                 limit: 24
    t.float    "sl_applied",                 limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

  create_table "likes", force: true do |t|
    t.boolean  "is_like"
    t.integer  "employee_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", force: true do |t|
    t.integer  "role_id"
    t.integer  "feature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_roll_masters", force: true do |t|
    t.date     "assesment_year"
    t.float    "total_income",          limit: 24
    t.float    "total_savings",         limit: 24
    t.float    "total_tds",             limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
    t.float    "net_taxable_income",    limit: 24
    t.float    "income_tax",            limit: 24
    t.float    "education_cess",        limit: 24
    t.float    "higher_education_cess", limit: 24
    t.float    "total_tax",             limit: 24
    t.string   "status"
  end

  create_table "payslips", force: true do |t|
    t.string   "month_and_year"
    t.float    "no_of_working_days", limit: 24
    t.float    "total_deductions",   limit: 24
    t.float    "arrears",            limit: 24
    t.float    "netpay",             limit: 24
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "working_days",       limit: 24
    t.float    "basic_salary",       limit: 24
    t.float    "gross_salary",       limit: 24
    t.float    "pf",                 limit: 24
    t.float    "esic",               limit: 24
    t.float    "pt",                 limit: 24
    t.float    "tds",                limit: 24
    t.float    "special_allowance",  limit: 24
    t.integer  "month"
    t.integer  "year"
    t.string   "status"
    t.string   "mode"
    t.float    "hra",                limit: 24
    t.float    "deductible_arrears", limit: 24
  end

  create_table "payslips_allowances", force: true do |t|
    t.integer  "allowance_id"
    t.integer  "payslip_id"
    t.boolean  "is_deductable", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "policies", force: true do |t|
    t.string   "title"
    t.text     "details"
    t.string   "document"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "roles"
    t.text     "tasks_performed"
    t.text     "skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

  create_table "promotions", force: true do |t|
    t.string   "date_of_promotion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
    t.integer  "designation_id"
    t.integer  "department_id"
    t.integer  "grade_id"
  end

  add_index "promotions", ["designation_id"], name: "index_promotions_on_designation_id", using: :btree
  add_index "promotions", ["employee_id"], name: "index_promotions_on_employee_id", using: :btree

  create_table "qualifications", force: true do |t|
    t.string   "qualification_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recruitments", force: true do |t|
    t.string   "jobcode"
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "file"
    t.string   "job_type"
  end

  create_table "reporting_managers", force: true do |t|
    t.integer  "department_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "manager_id"
  end

  create_table "review_elements", force: true do |t|
    t.string   "review_element"
    t.string   "performance_indicator"
    t.string   "employee_assesment"
    t.string   "employee_rating"
    t.string   "manager_feedback"
    t.string   "manager_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_previliges", force: true do |t|
    t.text     "previlige_url"
    t.text     "user_interface_url"
    t.text     "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  add_index "role_previliges", ["role_id"], name: "index_role_previliges_on_role_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.integer  "designation_id"
  end

  create_table "salaries", force: true do |t|
    t.float    "ctc_fixed",         limit: 24
    t.float    "basic_salary",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "gross_salary",      limit: 24
    t.float    "gratuity",          limit: 24
    t.float    "bonus",             limit: 24
    t.float    "medical_insurance", limit: 24
    t.float    "pf",                limit: 24
    t.float    "esic",              limit: 24
    t.float    "special_allowance", limit: 24
    t.string   "pf_apply"
    t.string   "esic_apply"
    t.float    "pf_contribution",   limit: 24
    t.float    "esic_contribution", limit: 24
    t.float    "hra",               limit: 24
  end

  create_table "salaries_allowances", force: true do |t|
    t.integer  "salary_id"
    t.integer  "allowance_id"
    t.string   "apply_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salary_increments", force: true do |t|
    t.string   "increment_date"
    t.float    "increment_value", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salary_id"
  end

  add_index "salary_increments", ["salary_id"], name: "index_salary_increments_on_salary_id", using: :btree

  create_table "section_declarations", force: true do |t|
    t.string   "section"
    t.float    "maximum_limit", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts", force: true do |t|
    t.string   "name"
    t.string   "from_time"
    t.string   "to_time"
    t.boolean  "is_next_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_allowances", force: true do |t|
    t.string   "name"
    t.float    "percentage",    limit: 24
    t.float    "value",         limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_deductable"
  end

  create_table "static_salaries", force: true do |t|
    t.string   "name"
    t.float    "value",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.text     "status"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes_count", default: 0
  end

  create_table "tax_brackets", force: true do |t|
    t.string   "bracket"
    t.float    "lower_limit",    limit: 24
    t.float    "upper_limit",    limit: 24
    t.integer  "tax_percentage"
    t.float    "min_tax",        limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_exemptions", force: true do |t|
    t.string   "gender"
    t.float    "exemption_limit", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temporary_attendence_logs", force: true do |t|
    t.integer  "device_id"
    t.integer  "employee_id"
    t.datetime "date_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.boolean  "is_active",              default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
