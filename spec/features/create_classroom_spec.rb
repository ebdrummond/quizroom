require 'spec_helper'

describe "creates a classroom" do
  it "creates a classroom with a logged in teacher" do
    u = User.new(first_name: "joe", last_name:"smith", email: "abc@example.com")
    u.password = "password"
    u.password_confirmation = "password"
    u.save!

    visit new_classroom_path
    fill_in 'class_name', :with => "English"
    click_button 'create'
    
    expect(current_path).to eq classroom_path(current_classroom)
#     Given I am an authenticated teacher
# And i am on the Create a classroom
# Then I can give the classroom the name 'Name'
# And when I click 'create'
# Then I am taken to the classroom, "Name"


  end
end