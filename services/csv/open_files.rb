require 'csv'
require_relative "#{ROOT_DIR}/app/concerns/errors"

module Services
  module CSV
    class OpenFiles
      include Errors

      def self.call(cli_args)
        new.call(cli_args)
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
          ::CSV.open("#{ROOT_DIR}/#{file_name}")
        rescue Errno::ENOENT
          print_error_open_file(file_name) and exit_app
        end
      end

      def count_files(csv_files)
        print_error_wrong_number_files and exit_app if csv_files.size != 2
      end
    end
  end
end
