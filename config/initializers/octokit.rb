class DalliAdapter
  attr_accessor :dalli_client

  def initialize(dalli_client)
    @dalli_client = dalli_client
  end

  def read(*args)
    @dalli_client.get(*args)
  end

  def write(*args)
    @dalli_client.set(*args)
  end

  # Send everything else along unchanged.
  def method_missing(name, *args, &block)
    dalli_client.send name, *args, &block
  end

  def self.build
    password = ENV["MEMCACHIER_PASSWORD"]
    servers = ENV["MEMCACHIER_SERVERS"]
    username = ENV["MEMCACHIER_USERNAME"]
    if servers.blank?
      DalliAdapter.new(Dalli::Client.new)
    else
      DalliAdapter.new(Dalli::Client.new(servers, {:username => username, :password => password}))
    end
  end
end

Octokit.middleware = Faraday::Builder.new do |builder|
  builder.response :logger if Rails.env.development?
  builder.use Faraday::HttpCache, DalliAdapter.build
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end
