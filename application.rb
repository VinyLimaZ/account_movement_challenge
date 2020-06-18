require 'Sequel'
require_relative 'app/concerns/errors'

class Application
  include Errors

  def initialize
    connect_db
    start_app
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

  def start_app
    require_relative 'main'
    Main.new(ARGV)
  end
end

Application.new
