require 'spec_helper'

describe "Signing in" do

  it "prompts for an email and password" do
    visit root_url

    click_link 'Sign In'

    expect(current_path).to eq(signin_path)

    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
  end

  it "signs in the user if the email/password combination is valid" do
    user = User.create!(user_attributes)

    visit root_url

    click_link 'Sign In'

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button 'Sign In'

    expect(current_path).to eq(user_path(user))

    expect(page).to have_text ("Welcome back #{user.username}!")
    expect(page).to have_link(user.name)
    expect(page).to have_link('Sign Out')
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')


  end

  it "does not sign in the user if the email/password combination is invalid" do
    user = User.create!(user_attributes)

    visit root_url

    click_link 'Sign In'

    fill_in "Email", with: user.email
    fill_in "Password", with: "no match"

    click_button 'Sign In'

    expect(page).to have_text('Invalid')
    expect(page).to have_link('Sign In')
    expect(page).to have_link('Sign Up')
    expect(page).not_to have_link(user.name)
    expect(page).not_to have_link('Sign Out')
  end


  describe "authenticate" do
    before do
      @user = User.create!(user_attributes)
    end

    it "returns false if the email does not match" do
      expect(User.authenticate("nomatch", @user.password)).to be_false
    end

    it "returns false if the password does not match" do
      expect(User.authenticate(@user.email, "nomatch")).to be_false
    end

    it "returns the user if the email and password match" do
      expect(User.authenticate(@user.email, @user.password)).to eq(@user)
    end

  end

  describe "Retour sur origine " do

    it "redirects to the intended page" do
     user = User.create!(user_attributes)

      visit users_url

      expect(current_path).to eq(new_session_path)

      sign_in(user)

      expect(current_path).to eq(users_path)
    end

  end

end