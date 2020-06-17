require 'csv'

module Services
  module CSV
    class OpenFiles
      def self.call(cli_args)
        new().call(cli_args)
      end

      def call(cli_args)
        csv_files = open(cli_args)
        count_files(csv_files)
        csv_files
      end

      private
      def initialize; end

      def open(csv_file_paths)
        csv_file_paths.map do |file_name|
          ::CSV.open("#{Dir.pwd}/#{file_name}")
        rescue Errno::ENOENT
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
end
