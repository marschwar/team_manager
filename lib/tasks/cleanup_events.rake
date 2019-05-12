desc "This task removes old events from the database"

task :cleanup_events => :environment do
	puts "Removing events older than 6 months"
	Participation.joins(:event).where("events.event_date < ?", 6.months.ago).delete_all
	Event.where("event_date < ?", 6.months.ago).delete_all
	puts "done."
end