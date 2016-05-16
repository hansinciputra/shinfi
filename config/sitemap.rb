# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.shinfithecraft.com"


SitemapGenerator::Sitemap.default_host = "http://www.shinfithecraft.com"
SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/sitemap-generator/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
SitemapGenerator::Sitemap.create do
  add 'hello_world!'
  add 'another'
end

SitemapGenerator::Sitemap.create do
  add crafts_path
  add compinfos_path
  add brands_path
  add inventories_path

 Inventory.find_each do |inventory|
       add inventories_path(inventory), :lastmod => inventory.updated_at
  end
  Craft.find_each do |craft|
       add crafts_path(craft), :lastmod => craft.updated_at
  end
  Compinfo.find_each do |info|
       add compinfos_path(info), :lastmod => info.updated_at
  end
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
end
