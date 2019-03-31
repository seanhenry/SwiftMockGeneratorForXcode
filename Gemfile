source "https://rubygems.org"

gem "fastlane"
gem "bundler", "1.17.3"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
