TOP_TAG_TYPES = ["license", "tech", "category", "usecase", "platform"]
TAG_COLORS = {
  "license" => "bg-amber-500",
  "tech" => "bg-gray-500",
  "category" => "bg-lime-500",
  "usecase" => "bg-orange-400",
  "platform" => "bg-red-500"
}
REPOSITORY_DATA_QUERY = Rails.root.join("app", "graphql", "github_repo.graphql").read
