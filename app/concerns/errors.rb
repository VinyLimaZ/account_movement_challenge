module App
  module Errors
    def print_error_wrong_number_files
      p "#{system_close_message}"
      p "Wrong number of files! The system needs an accounts and" \
        "a transactions csv files to operate properly"
    end

    def print_error_open_file(file_name)
      p "#{system_close_message}"
      p "The file: #{file_name} wasn't found, please verify if " \
        "the file exists and/or is inside app directory"
    end

    def system_close_message
      'The system found an error and will close!'
    end

    def print_wrong_file_type_error
      p system_close_message
      p 'Wrong file type! Verify if the file is a valid CSV and try again'
    end

    def exit_app
      exit
    end
  end
end
