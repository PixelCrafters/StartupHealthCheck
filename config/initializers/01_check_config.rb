unless File.exists? ("#{Rails.root}/config/initializers/startup_healthcheck.rb")
  raise "Please create a file called startup_healthcheck.rb in config/initializers/. Use startup_healthcheck.rb.sample to get started."
end
