require_relative 'services/csv/open_files'

class Main
  def initialize
    @accounts_csv, @transaction_csv = Services::CSV::OpenFiles.new(ARGV).files
  end
end

Main.new
