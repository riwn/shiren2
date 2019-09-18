# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://shiren2.herokuapp.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

case Rails.env
when 'production'
  SitemapGenerator::Sitemap.sitemaps_host = 'https://s3-ap-northeast-1.amazonaws.com/shiren2records'
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  "shiren2records",
  aws_access_key_id: ENV['AWS_SHIREN2_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SHIREN2_SECRET_ACCESS_KEY'],
  aws_region: ENV['AWS_SHIREN2_REGION'],
)
when 'development'
  SitemapGenerator::Sitemap.sitemaps_host = 'https://s3-ap-northeast-1.amazonaws.com/devshiren2records'
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
    "devshiren2records",
    aws_access_key_id: ENV['AWS_SHIREN2_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SHIREN2_SECRET_ACCESS_KEY'],
    aws_region: ENV['AWS_SHIREN2_REGION'],
  )
end


SitemapGenerator::Sitemap.create do
  add "/", :priority => 1, :changefreq => 'daily'
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
