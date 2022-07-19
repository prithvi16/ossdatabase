class GithubApi
  def self.client
    @client ||= Octokit::Client.new(access_token: ENV["GITHUB_API_ACCESS_TOKEN"])
  end
end
