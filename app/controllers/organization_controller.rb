class OrganizationController < ApplicationController
  
  layout "org", only: :index
  
  def index
  data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Name'   )
    data_table.new_column('string', 'Manager')
    data_table.new_column('string', 'ToolTip')
    a=[]
    Employee.all.each do |employee|
     desg = employee.designation.present? ? employee.designation.designation_name : ' '
     b=  [{:v => employee.full_name, :f =>"#{employee.full_name}<div style='color:red; font-style:italic'>#{desg}</div>" },  employee.reporting_manager, desg]
     a << b
    end
    data_table.add_rows(a)

    opts   = { :allowHtml => true }
    @chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts) 
  end
  
 
end





=begin
class OrganizationController < ApplicationController
  
  layout "org", only: :index
  
  def index
  data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Name'   )
    data_table.new_column('string', 'Manager')
    data_table.new_column('string', 'ToolTip')
    data_table.add_rows( [
      [ {:v => 'Mike', :f => 'Mike<div style="color:red; font-style:italic">President</div>'   }, ''    , 'The President' ],
      [ {:v => 'Jim' , :f => 'Jim<div style="color:red; font-style:italic">Vice President<div>'}, 'Mike', 'VP'            ],
      [ 'Alice'  , 'Mike', ''           ],
      [ 'Bob'    , 'Jim' , 'Bob Sponge' ],
      [ 'Carol'  , 'Bob' , ''           ]
    ] )

    opts   = { :allowHtml => true }
    @chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
  end
  
end
=end
