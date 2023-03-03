# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

# Application
pin 'application', preload: true

# Rails defaults
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true

# Controllers
pin_all_from 'app/javascript/controllers', under: 'controllers'

# Packages
pin 'el-transition' # @0.0.7
