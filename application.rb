require 'Sequel'
require_relative 'app/concerns/errors'

class Application
  include Errors

  def initialize
    connect_db
    run_migrations
    start_app
    clean_db
  end

  def connect_db
    begin
      $db = Sequel.connect(adapter: :postgres, database: 'amc', host: 'localhost')
    rescue StandardError => e
      p system_close_message(e)
      p database_conn_error
      exit_app
    end
  end

  def run_migrations
    `sequel -m db/migrate/ postgres://localhost/amc`
  end

  def clean_db
    $db[:accounts].delete
  end

  def start_app
    require_relative 'main'
    Main.new(ARGV)
  end
end

Application.new
