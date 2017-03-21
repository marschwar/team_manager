class MemberStatus < ActiveRecord::Base
   belongs_to :player
   validates_presence_of :rental_equipment

   def self.latest_import_date
    latest = MemberStatus.maximum(:updated_at)
    Time.at(latest).to_date if latest.present?
   end
end
