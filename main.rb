require_relative 'services/csv/open_files'

class Main
  def initialize
    @accounts_csv, @transaction_csv = Services::CSV::OpenFiles.call(ARGV)
  end
end

Main.new
