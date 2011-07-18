class Clock
  def self.at( *params )
    #TODO fix this
    eval("Time.at #{params.join(',')}")
  end

  def self.now
    Time.now
  end

  def self.time=
    raise "Cannot set real Clock class"
  end
end