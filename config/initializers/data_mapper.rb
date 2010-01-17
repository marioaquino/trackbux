module DataMapperInitializer
  def self.registered(app)
    # app.configure(:development) { DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/dev.db") }
    app.configure(:development) { DataMapper.setup(:default, "postgres://postgres:password@localhost/budgetminder_development") }
    app.configure(:test)        { DataMapper.setup(:default, 'sqlite3::memory:') }
    app.configure(:production)  { DataMapper.setup(:default, ENV['DATABASE_URL']) }
  end
end
