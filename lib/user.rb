require 'bcrypt'

class User

	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation
	validates_confirmation_of :password

	property :id, Serial
	property :email, String
	# this will store both the password and the salt
  # It's Text and not String because String holds 
  # 50 characters by default
  # and it's not enough for the hash and salt
	property :password_digest, Text

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

end