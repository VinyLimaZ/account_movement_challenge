require_relative "#{Dir.pwd}/app/concerns/errors"

module Services
  module Printer
    class AccountInfo
      include Errors

      def self.call
        new.call
      end

      def initialize; end

      def call
        print_account_info(Services::DB::Account.all_ordered)
      end

      private
      def print_account_info(accounts)
        p account_info_not_found_error and exit_app if accounts.empty?

        accounts.each do |account|
          p "#{account.id},#{account.balance}"
        end
      end
    end
  end
end
