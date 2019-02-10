desc "This task removes old sessions from the database"
task :cleanup_sessions => :environment do
  puts "Removing old sessions..."
  ActiveRecord::SessionStore::Session.delete_all(["updated_at < ?", 2.weeks.ago])
  puts "done."
end
