require 'sequel'

Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key :id
      Integer :balance
    end
  end
end
