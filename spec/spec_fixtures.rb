
user = User.new
user.username = 'admin'
user.password = 'admin'
user.password_confirmation = user.password
user.save

