module DataMapperInitializer
  def self.registered(app)
    app.configure(:development) { DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/dev.db") }
    app.configure(:test)        { DataMapper.setup(:default, 'sqlite3::memory:') }
    # FIXME
    # app.configure(:production)  { DataMapper.setup(:default, 'your_production_db_here') }
  end
end
