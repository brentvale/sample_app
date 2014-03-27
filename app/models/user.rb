class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	#ensures email uniqueness by downcasing the email attribute
	#the reason: not all database adapters use case-sensitive indices
	#we use a 'callback' which is a method that gets invoked at a particular
	#moment in the lifetime of a Record Object...in this case that callback
	#is the before_save callback on the @user

	validates(:name, presence: true, length: {maximum: 50} )
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i			
	validates(:email, 	presence: true, 
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false })
	#:uniqueness accepts an option, case_sensitive
	#can be written without parentheses

	validates :password, length: { minimum: 6 }
	has_secure_password
end
