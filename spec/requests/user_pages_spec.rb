require 'spec_helper'

describe "User pages" do

	#subject { page }

  describe "signup page" do
  	#before { visit signup_path }

    it "should have the content 'Sign up'" do
      visit signup_path
      expect(page).to have_content('Sign up')
    end
    
    #it { should have_title(full_title('Sign up')) }

    it "should have the title 'Sign up'" do
      visit signup_path
      expect(page).to have_title('Sign up')
    end
    
  end
end
