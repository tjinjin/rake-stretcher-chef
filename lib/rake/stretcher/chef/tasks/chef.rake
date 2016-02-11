# -*- coding: utf-8; mode: ruby -*-

require 'rake/stretcher'

namespace :stretcher do

  desc "Create tarball"
  task :archive_project =>
  [:ensure_directories, :checkout_local,
   :bundle,
   :create_tarball, :upload_tarball,
   :create_and_upload_manifest
  ]

  desc "bundle install"
  task :bundle do
    Bundler.with_clean_env do
      sh <<-EOC
        bundle install \
        --gemfile #{local_build_path}/Gemfile \
        --deployment --path vendor/bundle -j 4 \
        --without development test RAILS_ENV="#{environment}"
      EOC
    end
  end
end
