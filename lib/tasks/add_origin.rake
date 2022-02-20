desc "Add origin"
task :add_origin, [:url] => :environment do |task, args|
  AllowedOrigin.create!(url: args[:url].to_s)
end
