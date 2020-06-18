module Errors
  def error_wrong_number_files
    system_close_message +
      "Wrong number of files! The system needs an accounts and" \
      "a transactions csv files to operate properly"
  end

  def error_open_file(file_name)
    system_close_message +
      "The file: #{file_name} wasn't found, please verify if " \
      "the file exists and/or is inside app directory"
  end

  def system_close_message
    'The system found an error and will close! '
  end

  def wrong_file_type_error
    system_close_message +
      'Wrong file type! Verify if the file is a valid CSV and try again'
  end

  def account_not_found_to_update_error(id)
    "Account with id: #{id} wasn't found! Please verify the CSV, " +
      "the app will continue. "
  end

  def account_not_found_error
    'The system didnt find any account information. Verify the CSV files!'
  end

  def undefined_error(exception)
    'The System encountered an undefined problem and need to be closed!'
    "Problem: #{e.full_message}"
  end

  def database_conn_error
    'The sytem found a database connection error! Call our support!'
  end

  def backtrace(e)
    e.backtrace
  end

  def exit_app
    exit
  end
end
