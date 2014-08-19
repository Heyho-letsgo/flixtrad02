require 'spec_helper'

describe "Deleting a user" do
  it "Only admin can destroy a user and redirects to the home page" do
    admin = User.create!(user_attributes(admin: 't'))
    sign_in(admin)

    user = User.create!(user_attributes(admin: 'f', email:'user@gmail.com', username:'username2'))

    user=User.find_by(admin: 'f')

    visit user_path(user.id)
    click_link 'Delete Account'
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Account successfully deleted!')
    expect(page).not_to have_text(user.username)

  end

  it "A user can not destroy a user" do
    user = User.create!(user_attributes(admin: 'f'))
    sign_in(user)
    visit user_path(user.id)
    expect(page).not_to have_link('Delete Account')
    expect(page).to have_text(user.name)

  end


=begin


  it "automatically signs out that user" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_path(user)

    click_link 'Delete Account'

    expect(page).to have_link('Sign In')
    expect(page).not_to have_link('Sign Out')
  end
=end


end
