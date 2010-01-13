class User
  include DataMapper::Resource
  
  property :id,               Serial
  property :username,         String
  property :crypted_password, String

  attr_accessor :password, :password_confirmation
  
  before :save, :encrypt_password
  
  validates_present :password, :password_confirmation

  def self.authenticate(username, password)
    user = User.first(:username => username)
    user && user.has_password?(password) ? user : nil
  end
  
  def self.find(id)
    User.first(:id => id)
  end
  
  def encrypt_password
    self.crypted_password = BCrypt::Password.create(password)
  end
  
  def has_password?(password)
    BCrypt::Password.new(crypted_password) == password
  end
end

User.auto_upgrade!
