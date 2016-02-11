# -*- coding: utf-8; mode: ruby -*-

require 'rake/stretcher'

namespace :stretcher do

  desc "Create tarball"
  task :archive_project =>
  [:ensure_directories, :checkout_local,
   :bundle, :submodule, :berks,
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

  desc "submodule update"
  task :submodule do
    sh <<-EOC
      git submodule update
    EOC
  end

  desc "community cookbook install"
  task :berks do
    sh <<-EOC
      cd #{local_build_path}
      bundle exec berks vendor cookbooks
    EOC
  end
end
