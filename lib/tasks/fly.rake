# frozen_string_literal: true

# commands used to deploy a Rails application
namespace :fly do
  desc 'Build Step'
  task build: 'assets:precompile'
  #  - changes to the filesystem made here DO get deployed
  #  - NO access to secrets, volumes, databases
  #  - Failures here prevent deployment

  desc 'Release Step'
  task release: 'db:migrate'
  #  - changes to the filesystem made here are DISCARDED
  #  - full access to secrets, databases
  #  - failures here prevent deployment

  desc 'Deploy Step'
  task :deploy, [:cache] => :environment do |_t, args|
    args.with_defaults(cache: 1)

    cmd = 'flyctl deploy -e APP_REVISION=$(git rev-parse --short HEAD)'
    cmd += ' --no-cache' if args[:cache].to_i.zero?

    sh cmd
  end

  desc 'Remote SSH'
  task ssh: :environment do
    sh 'flyctl ssh console'
  end

  desc 'Remote Rails Console'
  task console: :environment do
    sh 'flyctl ssh console -C "app/bin/rails console"'
  end

  desc 'Remote Logs'
  task logs: :environment do
    sh 'flyctl logs'
  end

  desc 'Remote Database Console'
  task dbconsole: :environment do
    sh 'flyctl ssh console -C "app/bin/rails dbconsole"'
  end

  desc 'Remote Redis Console'
  task redis: :environment do
    sh 'flyctl redis connect'
  end
end
