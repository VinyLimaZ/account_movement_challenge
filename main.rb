require_relative 'services/csv/open_files'

class Main
  def initialize(app = Application)
    instantiate_db(app)
    @accounts_csv, @transaction_csv = Services::CSV::OpenFiles.call(ARGV)
  end

  def instantiate_db(app)
    app.new
  end
end

Main.new
