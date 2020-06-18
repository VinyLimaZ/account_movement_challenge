require 'sequel'
require_relative "#{Dir.pwd}/app/concerns/errors"

module Services
  module DB
    class Account < Sequel::Model
      class << self
        include Errors

        def upsert_all(rows)
          rows.each do |row|
            upsert(id: row[0], balance: row[1])
          end
        end

        def get(id)
          self[id]
        end

        def upsert(id:, balance:)
          accounts_db.
            insert_conflict(target: :id, update: { balance: balance }).
            insert(id: id, balance: balance)
        end

        def safe_upsert(id:, balance:)
          if get(id)
            upsert(id: id, balance: balance)
          else
            p system_close_message
            p account_not_found_to_update_error(id)
            exit_app
          end
        end

        def all_ordered
          self.order(:id).all
        end

        def accounts_db
          $db[:accounts]
        end
      end
    end
  end
end
