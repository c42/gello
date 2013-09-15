module OctokitHelpers
  def access_token
    @github_access_token
  end

  def access_token=(github_access_token)
    @github_access_token = github_access_token
  end

  def repos_with_issues
    repos.select(&:has_issues)
  end

  private
  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: access_token, auto_paginate: true)
  end

  def octokit_user
    octokit_client.user
  end
end
