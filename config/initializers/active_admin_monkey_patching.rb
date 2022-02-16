ActiveAdmin::ResourceController.class_eval do
  def find_resource
    finder = resource_class.is_a?(FriendlyId) ? :slug : :id
    scoped_collection.find_by(finder => params[:id])
  end
end
