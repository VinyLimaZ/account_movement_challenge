require_relative "#{ROOT_DIR}/services/db/account"

module Services
  module Calculate
    class Transactions
      BANK_FINE = 300

      def self.update_all(rows)
        new.call(rows)
      end

      def initialize; end

      def call(rows)
        rows.each do |row|
          transaction(row[0], row[1])
        end
      end

      private
      def transaction(id, value)
        debit(id, value) if value.negative?
        credit(id, value) if value.positive?
      end

      def debit(id, value)
        balance = get_balance(id)
        balance -= value.abs
        balance -= BANK_FINE if balance.negative?
        set_balance(id, balance)
      end

      def credit(id, value)
        balance = get_balance(id)
        balance += value
        set_balance(id, balance)
      end

      def get_balance(id)
        Services::DB::Account.get(id).balance
      end

      def set_balance(id, balance)
        Services::DB::Account.safe_upsert(id: id, balance: balance)
      end
    end
  end
end
