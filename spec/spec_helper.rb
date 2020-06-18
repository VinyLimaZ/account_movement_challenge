require 'sequel'
require 'database_cleaner'
# run migrations before the specs
`sequel -m db/migrate/ postgres://localhost/amc_test`

CSV_FIXTURE_DIR = "./spec/fixtures/csv"
ROOT_DIR = Dir.pwd

$db = Sequel.connect(adapter: :postgres, database: 'amc_test', host: 'localhost')
DatabaseCleaner[:sequel].db = $db

RSpec.configure do |config|
  config.color = true

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
