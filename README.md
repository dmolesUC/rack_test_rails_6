# Test case for running system specs with Rack::Test

Steps to reproduce:

1. Build Docker stack

   ```sh
   docker-compose up --pull
   ```

2. Run RSpec tests in Docker container

   ```sh
   docker-compose run --rm rails spec
   ```
   
Expected:

- Tests pass, just as if you ran `bundle install && rails spec` on a machine with Chrome installed
- Tests error with:

  ```
  Webdrivers::BrowserNotFound:
    Failed to find Chrome binary.
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/chrome_finder.rb:21:in `location'
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/chrome_finder.rb:10:in `version'
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/chromedriver.rb:46:in `browser_version'
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/chromedriver.rb:106:in `release_version'
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/chromedriver.rb:32:in `latest_version'
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/common.rb:135:in `correct_binary?'
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/common.rb:91:in `update'
  # /usr/local/bundle/ruby/2.6.0/gems/webdrivers-4.1.3/lib/webdrivers/chromedriver.rb:119:in `block in <main>'
  # /usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.0/lib/active_support/core_ext/object/try.rb:15:in `public_send'
  # /usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.0/lib/active_support/core_ext/object/try.rb:15:in `try'
  # /usr/local/bundle/ruby/2.6.0/gems/actionpack-6.0.0/lib/action_dispatch/system_testing/browser.rb:50:in `preload'
  # /usr/local/bundle/ruby/2.6.0/gems/actionpack-6.0.0/lib/action_dispatch/system_testing/driver.rb:13:in `initialize'
  # /usr/local/bundle/ruby/2.6.0/gems/actionpack-6.0.0/lib/action_dispatch/system_test_case.rb:159:in `new'
  # /usr/local/bundle/ruby/2.6.0/gems/actionpack-6.0.0/lib/action_dispatch/system_test_case.rb:159:in `driven_by'
  # /usr/local/bundle/ruby/2.6.0/gems/actionpack-6.0.0/lib/action_dispatch/system_test_case.rb:162:in `<class:SystemTestCase>'
  # /usr/local/bundle/ruby/2.6.0/gems/actionpack-6.0.0/lib/action_dispatch/system_test_case.rb:114:in `<module:ActionDispatch>'
  # /usr/local/bundle/ruby/2.6.0/gems/actionpack-6.0.0/lib/action_dispatch/system_test_case.rb:16:in `<main>'
  # /usr/local/bundle/ruby/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22:in `require'
  # /usr/local/bundle/ruby/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22:in `block in require_with_bootsnap_lfi'
  # /usr/local/bundle/ruby/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/loaded_features_index.rb:92:in `register'
  # /usr/local/bundle/ruby/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:21:in `require_with_bootsnap_lfi'
  # /usr/local/bundle/ruby/2.6.0/gems/bootsnap-1.4.5/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30:in `require'
  # /usr/local/bundle/ruby/2.6.0/gems/zeitwerk-2.2.0/lib/zeitwerk/kernel.rb:23:in `require'
  # /usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.0/lib/active_support/concern.rb:122:in `class_eval'
  # /usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.0/lib/active_support/concern.rb:122:in `append_features'
  # ./spec/system/foos_spec.rb:3:in `<top (required)>'
  ```