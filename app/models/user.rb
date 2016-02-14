class User < ActiveRecord::Base
	#attr_accessor enable us to read and write the password method of user. It also create the password method
	attr_accessor :password
	has_many :orders, dependent: :destroy #dependent: :destroy - if customer is deleted , all of the customers order also deleted
	
	before_save :encrypt_password
	validates :name, :email, :presence =>true
	#validates_confirmation_of the :password from view
	validates_presence_of :password, :on => :create
	validates_confirmation_of :password, :message => "password doesn't match"
	validates_uniqueness_of :email, :message => "alamat email sudah terdaftar"

def encrypt_password
	if password.present?
		self.password_salt = BCrypt::Engine.generate_salt
		#the model onyl has password_hash and password_salt as params, so, the :password that we specified in view need to go through attr_accessor and be send to password_hash
		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end	
end
def self.check_password(email,password)
	user = find_by_email(email)
	if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
  		user
  	else
  		nil
  	end
end
  def self.check_login(email,password)
  	user = find_by_email(email)

  	#no clue as the BCrypt ways of generate decrypt data into password_hash
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
  		user
  	else
  		nil
  	end
  end
end
