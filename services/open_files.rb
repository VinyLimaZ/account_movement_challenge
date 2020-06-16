module Services
  class OpenFiles
    attr_reader :csv_files

    def initialize(cli_args)
      @csv_files = open(cli_args)
      count_files(@csv_files)
    end

    private
    def open(file_names)
      file_names.map do |file_name|
        File.open("#{Dir.pwd}/#{file_name}")
      rescue Errno::ENOENT => e
        print_error_open_file(file_name) and exit_app
      end
    end

    def count_files(csv_files)
      print_error_wrong_number_files and exit_app if csv_files.size != 2
    end

    def print_error_wrong_number_files
      p "#{system_close_message}"
      p "Wrong number of files! The system needs an accounts and \
      a transactions csv files to operate properly".squeeze(' ')
    end

    def print_error_open_file(file_name)
      p "#{system_close_message}"
      p "The file: #{file_name} wasn't found, please verify if \
      the file exists and/or is inside app directory".squeeze(' ')
    end

    def system_close_message
      'The system found an error and will close!'
    end

    def exit_app
      exit
    end
  end
end
