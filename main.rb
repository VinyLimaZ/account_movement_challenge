require_relative 'app/concerns/errors'
require_relative 'services/csv/open_files'
require_relative 'services/csv/sanitize_file'
require_relative 'services/db/account'
require_relative 'services/calculate/transactions'
require_relative 'services/printer/account_info'


class Main
  include ::Errors
  attr_reader :accounts_csv, :transaction_csv
  def initialize(cli_args)
    begin
      accounts_csv, transaction_csv = open_files(cli_args)
      accounts_array = sanitize_file(accounts_csv)
      transaction_array = sanitize_file(transaction_csv)
      create_accounts(accounts_array)
      calculate_balance(transaction_array)
      print_account_balance
      close_files(accounts_csv, transaction_csv)
    rescue StandardError => e
      p system_close_message
      p backtrace(e)
      exit_app
    end
  end

  def open_files(cli_args)
    Services::CSV::OpenFiles.call(cli_args)
  end

  def sanitize_file(csv)
    Services::CSV::SanitizeFile.call(csv)
  end

  def create_accounts(acc_ary)
    Services::DB::Account.upsert_all(acc_ary)
  end

  def calculate_balance(transaction_array)
    Services::Calculate::Transactions.update_all(transaction_array)
  end

  def print_account_balance
    Services::Printer::AccountInfo.call
  end

  def close_files(account_csv, transaction_csv)
    account_csv.close
    transaction_csv.close
  end
end

