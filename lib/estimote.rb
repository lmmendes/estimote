module Estimote

  def self.new(credentials)
    @client = Client.new(credentials)
  end

  def self.client
    @client
  end

end
