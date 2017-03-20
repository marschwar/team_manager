class MemberStatusController < ApplicationController
  include TeamScoped

  def index
    players = Player.of_team(@team).includes(:member_status).sorted
    unknown_status = players.select { |p| p.member_status.blank? }
    invalid_rental_status = players.select(&:invalid_rental_status?)
    valid_status = players - unknown_status - invalid_rental_status
    @status = {
      unknown: unknown_status,
      invalid: invalid_rental_status,
      valid: valid_status
    }
  end
end
