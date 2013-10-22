###
# Compass
###

# Susy grids in Compass
# First: gem install susy --pre
# require 'susy'

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
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do
  def meta_description(page)
    if page.meta && page.meta.description
      page.meta.description
    else
      "Matt Button, Ruby Developer in the UK"
    end
  end

  def meta_keywords(page)
    if page.meta && page.meta.tags
      page.meta.tags
    else
      "ruby, PHP, kohana, kohanaphp, ruby on rails, memberful, membership, programming, university"
    end
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :fonts_dir, 'webfonts'

activate :blog do |blog|
  blog.layout  = "layouts/article"
  blog.sources = "archive/:year-:month-:day-:title.html"
end

activate :livereload
activate :syntax

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true


redirect '2009/11/virtualbox-1-differencing-child-hard-disks/index.html', to: '/2009/11/07/virtualbox-1-differencing-child-hard-disks.html'
redirect '2010/08/puppet-retrieved-certificate-does-not-match-private-key/index.html', to: '/2010/08/07/puppet-retrieved-certificate-does-not-match-private-key.html'
redirect '2008/07/textarea-maxlength-with-jquery/index.html', to: '/2008/07/05/textarea-maxlength-with-jquery.html'
redirect '2009/12/how-to-get-ubuntu-to-ping-a-windows-hostname/index.html', to: '/2009/12/02/how-to-get-ubuntu-to-ping-a-windows-hostname.html'
redirect '2010/04/updated-textarea-maxlength-with-jquery-plugin/index.html', to: '/2010/04/08/updated-textarea-maxlength-with-jquery-plugin.html'
redirect '2009/04/host-personal-svn-projects-for-free-using-dropbox/index.html', to: '/2009/04/13/host-personal-svn-projects-for-free-using-dropbox.html'
redirect '2010/08/config-cache-problems-with-magento/index.html', to: '/2010/08/01/config-cache-problems-with-magento.html'


# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS'
  sync.fog_directory = 'that-matt.com' # Your bucket name
  sync.fog_region = 'us-east-1'
  sync.aws_access_key_id = ENV['S3_ACCESS_KEY_ID']
  sync.aws_secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
  sync.existing_remote_files = 'delete'
  # sync.gzip_compression = false # Automatically replace files with their equivalent gzip compressed version
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
end

