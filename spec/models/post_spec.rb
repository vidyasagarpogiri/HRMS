require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe "Checking Statuses validations" do
  it "is valid with valied attributes" do
        expect(Post.create(title: "HRMS", content: "some text", employee_id: 1)).to be_valid
      end
 
  it "is not valid without  title" do
        expect(Post.create(title: nil, content: "some text", employee_id: 1)).to_not be_valid
      end
 
  it "is not valid without content" do
        expect(Post.create(title: "HRMS", content: nil, employee_id: 1)).to_not be_valid
      end

  it "is not valid with valied without employee_id" do
        expect(Post.create(title: "HRMS", content: "some text", employee_id: nil)).to_not be_valid
      end
  end
end
