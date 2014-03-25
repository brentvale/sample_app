require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
      #have_title method checks the content inside the HTML title tag
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do
  		#we are describing the About page

  	it "should have the content 'About Us'" do
  		#rspec says, when you visit /static_pages/about the content should have the words 'about'
  		visit '/static_pages/about'
  		#use the Capybara function visit to simulate visiting the URL /static_pages/home
  		expect(page).to have_content('About Us')
  		#using the page variable (provided by Capybara) to express the expectation that the resulting page should have the right content
  	end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end
  end	
end