require 'spec_helper'

describe User do

  before do
  	@user = User.new(name: "Example User", email: "user@example.com",
  			password: "foobar", password_confirmation: "foobar")
  end
  #creating with an example user because using the "respond_to" command below 
  #allows a genericized test to make sure it will work for future users

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
  	before { @user.name = " " }
  	#setting the block to invalid to check that the resulting user object 
  	#is not valid
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }

  	it { should_not be_valid}
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51}
  	it { should_not be_valid}
  end

  describe "when email format is invalid" do
  	it "should be invalid" do 
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
  						foo@bar_baz.com foo@bar+baz.com]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			expect(@user).not_to be_valid
  		end
  	end
  end

  describe "when email format is valid" do
  	it "should be valid" do 
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		#use dot upcase to test for case-insensitivity
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when password is not present" do
  	before do
  		@user = User.new(name: "Example User", email: "example@user.com",
  				password: " ", password_confirmation: " ")
  	end
  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	#seems like mismatch has no special meaning, its just setting the password confirmation
  	#to a string 'mismatch' that won't be used by the first password
  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @user.save }
  	# saves user to database so that it can be retrieved using find_by which we accomplish
  	# with the let method
  	let(:found_user) { User.find_by(email: @user.email) }
  	#let method is a convenient way  to create local variables inside tests

  	describe "with valid password" do
  		it { should eq found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid") }

  		it { should_not eq user_for_invalid_password }
  		specify { expect(user_for_invalid_password).to be_false}
  		#specify is a synonym of "it" and can be used when "it" would sound unnatural 
  	end
  end

  describe "with a password that's too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
  	it { should be_invalid }
  end

  describe "remember token" do
      before { @user.save }
      its(:remember_token) { should_not be_blank}
    end

end

