desc "This task removes old events from the database"

task :cleanup_events => :environment do
	puts "Removing events older than 4 months"
	Participation.joins(:event).where("events.event_date < ?", 4.months.ago).delete_all
	Event.where("event_date < ?", 4.months.ago).delete_all
	puts "done."
end