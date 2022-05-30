# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://ossdatabase.com"

SitemapGenerator::Sitemap.sitemaps_path = 'shared/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  Project.find_each do |project|
    add project_path(project), :lastmod => project.updated_at
  end

  Tag.find_each do |tag|
    add tag_show_path(tag)
  end

  add blog_path
  Article.find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end

  add projects_browse_path, :changefreq => 'daily'
  add nav_search_path, :changefreq => 'daily'
  add new_submission_path
end
