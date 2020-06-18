require 'Sequel'

ROOT_DIR = Dir.pwd

class Application
  def initialize
    connect_db
  end

  def connect_db
    $db = Sequel.connect(adapter: :postgres, database: 'amc', host: 'localhost')
  end
end
