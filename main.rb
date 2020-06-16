require_relative 'services/open_files'

class Main
  def initialize
    @accounts_csv, @transaction_csv = Services::OpenFiles.new(ARGV).files
  end
end

Main.new
