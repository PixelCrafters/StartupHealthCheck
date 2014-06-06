if Rails.env.development? || Rails.env.test?
  filename = Dir.pwd + "/config/initializers/env/#{Rails.env}.env"
  File.open(filename) do |f|
    f.each_line do |line|
      # my_var: 123
      k, v = line.split(': ')
      ENV[k.upcase] = v
    end
  end
end
