# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://ossdatabase.com'

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
    add project_path(project), lastmod: project.updated_at
    add alternatives_to_path(project.slug), lastmod: project.updated_at
  end

  Tag.find_each do |tag|
    add tag_show_path(tag)
  end

  add blog_path
  Article.find_each do |article|
    add article_path(article), lastmod: article.updated_at
  end

  add projects_browse_path, changefreq: 'daily'
  add search_path, changefreq: 'daily'
  add new_submission_path
  add open_source_path
  add open_source_license_picker_path
  add licenses_list_path
  add licenses_index_path

  License.find_each do |license|
    add license_path(license)
    add projects_with_license_path(license.key)
  end

  StaticPage.find_each do |page|
    add static_page_path(page.key)
  end

  add open_source_alternatives_path
  Tag.where(tag_type: 'usecase').find_each do |tag|
    add open_source_usecase_path("open-source-#{tag.slug}-software")
  end
end
