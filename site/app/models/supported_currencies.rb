module TrackBux
  module Currency
    def self.codes
      map.keys
    end
    
    private
    # FIXME: How slow is this?
    def self.map
      {"USD" => '$'}.merge(Money::SYMBOLS)
    end
  end
end
