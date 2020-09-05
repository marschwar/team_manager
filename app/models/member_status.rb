class MemberStatus < ApplicationRecord
   belongs_to :player

   def self.latest_import_date
    latest = MemberStatus.maximum(:updated_at)
    Time.at(latest).to_date if latest.present?
   end
end
