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
end

Octokit.middleware = Faraday::Builder.new do |builder|
  builder.response :logger if Rails.env.development?
  builder.use Faraday::HttpCache, DalliAdapter.new(Dalli::Client.new)
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end
