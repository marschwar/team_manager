module UploadSupport
  extend ActiveSupport::Concern

  def upload_file
    upload_params[:file] if upload_params[:file].present?
  end

  def upload_params
    params[:upload]
  end

  def import_file(file = upload_file)

    file.tempfile.read.force_encoding('UTF-8').gsub( /\r\n/, "\n" ).split("\n").each do |line|
      row_data = line.split(';')
      next unless row_data.count > 1

      line_as_hash = {}
      upload_attributes.each_with_index do |attr, idx|
        line_as_hash[attr.to_sym] = row_data[idx] if row_data.count > idx
      end

      yield line_as_hash
    end
  end
end