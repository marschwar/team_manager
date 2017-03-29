class MemberStatusController < ApplicationController
  include UploadSupport

  load_and_authorize_resource

  before_filter :set_team, only: [:index]

  def index
    scope = @team ? Player.of_team(@team) : Player.all
    players = scope.includes(:member_status).sorted
    unknown_status = players.select { |p| p.member_status.blank? }
    invalid_rental_status = players.select(&:invalid_rental_status?)
    valid_status = players - unknown_status - invalid_rental_status
    @status = {
      unknown: unknown_status,
      invalid: invalid_rental_status,
      valid: valid_status
    }
    @latest_import_date = MemberStatus.latest_import_date
  end

  def upload
    file = upload_file
    flash[:error] = I18n.translate('players.index.upload.errors.file_missing') unless file
    redirect_to member_status_index_path and return if flash[:error]

    players = Player.all.includes(:member_status).to_a

    @results = {}.tap do |r|
      r[:matched] = []
      r[:unmatched] = []
    end

    import_file file do |line|
      player = find_best_matching_player players, line
      if player.present?
        @results[:matched] << {player: player, data: line}
      else
        @results[:unmatched] << {data: line}
      end
    end

    matched_players = @results[:matched].map { |e| e[:player] }
    @results[:unknown] = players - matched_players

    unless dry_run?
      persist_matches @results[:matched]
      @results[:unknown].each do |player|
        player.member_status.destroy if player.member_status.present?
      end
    end
  end

  private

    def set_team
      team_id = params.delete :team_id
      @team = Team.find team_id if team_id
    end

    def dry_run?
      upload_params[:dry_run] == '1' if upload_params[:dry_run]
    end

    def upload_attributes
      %w(last_name first_name birthday rental_status)
    end

    def find_best_matching_player(players, line)
      find_matching_players(players, line).first
    end

    def find_matching_players(players, line)
      birthday = Date.parse(line[:birthday]) if line[:birthday].present?
      candidates = players.select { |p| p.matches?(line[:last_name], line[:first_name], birthday) }
      candidates.sort_by { |p| p.match_score(line[:last_name], line[:first_name], birthday) }.reverse
    end

    def persist_matches(matches)
      matches.each do |match_hash|
        player = match_hash[:player]
        member_status = player.member_status || MemberStatus.new(player: player)
        with_rental_fee = !!(match_hash[:data][:rental_status] =~ /Ausrüstung/)
        member_status.rental_equipment = with_rental_fee
        member_status.save!
      end
    end
end
