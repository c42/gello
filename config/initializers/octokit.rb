Octokit.middleware = Faraday::Builder.new do |builder|
  builder.response :logger if Rails.env.development?
  builder.use Faraday::HttpCache
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end