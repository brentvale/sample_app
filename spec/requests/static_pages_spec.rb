require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  #by telling rspec that page is the subject of the tests we can 
  #collapse the code description into one line
  subject { page }

  describe "Home page" do
    before { visit root_path }
    #helps us eliminate prior duplication of visit root_path for every second line
    #means before each example visit the root_path
    #before method can also be invoked with before(:each)


    it { should have_content('Sample App') }

    it { should have_title(full_title('')) }
     
    it { should_not have_title('| Home') }

     describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit help_path
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do
  		#we are describing the About page

  	it "should have the content 'About Us'" do
  		#rspec says, when you visit /static_pages/about the content should have the words 'about'
  		visit about_path
  		#use the Capybara function visit to simulate visiting the URL /static_pages/home
  		expect(page).to have_content('About Us')
  		#using the page variable (provided by Capybara) to express the expectation that the resulting page should have the right content
  	end

    it "should have the title 'About Us'" do
      visit about_path
      expect(page).to have_title("#{base_title} | About Us")
    end
  end	

  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end