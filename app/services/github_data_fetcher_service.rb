class GithubDataFetcherService
  def initialize(repo_path)
    @repo_path = repo_path
  end

  def fetch_data
    owner, name = @repo_path.split("/")
    body = {query: REPOSITORY_DATA_QUERY, variables: {owner: owner, name: name}}
    graphql_response = github_client.post "https://api.github.com/graphql", Oj.dump(body, mode: :compat)
    GithubRepositoryDataService.new(graphql_response)
  end

  def github_client
    @github_client ||= Octokit::Client.new(access_token: ENV["GITHUB_API_ACCESS_TOKEN"])
  end
end
