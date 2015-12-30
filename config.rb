###
# Blog settings
###

# Time.zone = "UTC"

# Current location
# Location history
## Bangkok
## Chiang Mai
@location = "Lamphun"
set :location, @location

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Obfuscate emails (https://github.com/amsardesai/middleman-protect-emails)
# activate :protect_emails

# This errors out without UTF encoding,
# incompatible encoding regexp match (Windows-31J regexp with UTF-8 string)


# Methods defined in the helpers block are available in templates
helpers do

  def nav_active(path)
    current_page.path == path ? {:class => "active"} : {}
  end

end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do

  # Requires middleman-favicon-maker
  activate :favicon_maker, :icons => {
    "_favicon_base.svg" => [
      { icon: "apple-touch-icon-152x152-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS7.
      { icon: "apple-touch-icon-144x144-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS6 or prior.
      { icon: "apple-touch-icon-120x120-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS7.
      { icon: "apple-touch-icon-114x114-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS6 or prior.
      { icon: "apple-touch-icon-76x76-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS7.
      { icon: "apple-touch-icon-72x72-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS6 or prior.
      { icon: "apple-touch-icon-60x60-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPhone with iOS7.
      { icon: "apple-touch-icon-57x57-precomposed.png" },               # iPhone and iPad users can turn web pages into icons on their home screen. Such link appears as a regular iOS native application. When this happens, the device looks for a specific picture. The 57x57 resolution is convenient for non-retina iPhone with iOS6 or prior. Learn more in Apple docs.
      { icon: "apple-touch-icon-precomposed.png", size: "57x57" },      # Same as apple-touch-icon.png, expect that is already have rounded corners (but neither drop shadow nor gloss effect).
      { icon: "apple-touch-icon.png", size: "57x57" },                  # Same as apple-touch-icon-57x57.png, for "default" requests, as some devices may look for this specific file. This picture may save some 404 errors in your HTTP logs. See Apple docs
      { icon: "favicon-196x196.png" },                                  # For Android Chrome M31+.
      { icon: "favicon-160x160.png" },                                  # For Opera Speed Dial (up to Opera 12; this icon is deprecated starting from Opera 15), although the optimal icon is not square but rather 256x160. If Opera is a major platform for you, you should create this icon yourself.
      { icon: "favicon-96x96.png" },                                    # For Google TV.
      { icon: "favicon-32x32.png" },                                    # For Safari on Mac OS.
      { icon: "favicon-16x16.png" },                                    # The classic favicon, displayed in the tabs.
      { icon: "favicon.png", size: "16x16" },                           # The classic favicon, displayed in the tabs.
      { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },         # Used by IE, and also by some other browsers if we are not careful.
      { icon: "mstile-70x70.png", size: "70x70" },                      # For Windows 8 / IE11.
      { icon: "mstile-144x144.png", size: "144x144" },
      { icon: "mstile-150x150.png", size: "150x150" },
      { icon: "mstile-310x310.png", size: "310x310" },
      { icon: "mstile-310x150.png", size: "310x150" }
    ]
  }
  
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Optimize images on build
  activate :imageoptim

  # gzip
  activate :gzip

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

configure :development do
  set :debug_assets, true
end

# Load a YML config file with constants.
# An aws.yml.example file is provided.

ignore 'aws.yml'
#aws_config = YAML::load(File.open('aws.yml'))

# config via https://github.com/monsoonco/Middleman-AWS-Prismic-CircleCi

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = ENV['AWS_S3_BUCKET_NAME']
  # The AWS region code for your bucket.
  # For region codes: http://www.bucketexplorer.com/documentation/amazon-s3--amazon-s3-buckets-and-regions.html
  s3_sync.region                     = ENV['AWS_REGION']
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_KEY']
  #s3_sync.delete                = true # We delete stray files by default.
  s3_sync.after_build           = true # We do not chain after the build step by default.
end

caching_policy 'text/html', cache_control: {max_age: 7200, must_revalidate: true}, content_encoding: 'gzip'
caching_policy 'image/png', cache_control: {max_age: 31536000, public: true}, content_encoding: 'gzip'
caching_policy 'image/jpeg', cache_control: {max_age: 31536000, public: true}, content_encoding: 'gzip'
caching_policy 'text/css', cache_control: {max_age: 31536000, public: true}, content_encoding: 'gzip'
caching_policy 'application/javascript', cache_control: {max_age: 31536000, public: true}, content_encoding: 'gzip'

activate :cloudfront do |cf|
  cf.access_key_id                   = ENV['AWS_ACCESS_KEY_ID']
  cf.secret_access_key               = ENV['AWS_SECRET_KEY']
  cf.distribution_id                 = ENV['PRODUCTION_CLOUDFRONT_DISTRIBUTION_ID']
  cf.filter                          = /\.html$/i
  cf.after_build                     = false  # default is false
end

#after_s3_sync do |files_by_status|
#  invalidate files_by_status[:updated]
#end

end
