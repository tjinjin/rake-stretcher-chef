# -*- coding: utf-8; mode: ruby -*-

require 'rake/stretcher'

namespace :stretcher do

  desc "Create tarball"
  task :archive_project =>
  [:ensure_directories, :checkout_local,
   :create_tarball, :upload_tarball,
   :create_and_upload_manifest
  ]
end
