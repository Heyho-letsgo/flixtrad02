require 'spec_helper'

describe "Favoriting a movie" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it "creates a favorite for the signed-in user and shows the Unfave button" do
    movie = Movie.create!(movie_attributes)

    visit movie_url(movie)
    expect {
      click_button 'Fave'
    }.to change(@user.favorites, :count).by(1)

    within("aside#sidebar") do
      expect(page).to have_text("Fans")
    end

    expect(current_path).to eq(movie_path(movie))

    expect(page).to have_text("Thanks for fav'ing!")
    expect(page).to have_text("1 fan")
    expect(page).to have_button("Unfave")
  end
end