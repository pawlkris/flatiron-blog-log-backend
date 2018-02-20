desc "This task is called by the Heroku scheduler add-on to get new medium posts"
task :pull_posts => :environment do
  puts "Updating posts..."
  Cohort.medium_update
  puts "done."
end
