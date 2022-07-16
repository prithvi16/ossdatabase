class GithubRepositoryDataService
  attr_accessor :raw_data
  private :raw_data=

  def initialize(raw_data)
    self.raw_data = raw_data.dig(:data, :repository)
  end
end
