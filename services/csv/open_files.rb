require 'csv'
require_relative "#{Dir.pwd}/app/concerns/errors"

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
          ::CSV.open("#{Dir.pwd}/#{file_name}")
        rescue Errno::ENOENT
          p error_open_file(file_name) and exit_app
        end
      end

      def count_files(csv_files)
        p error_wrong_number_files and exit_app if csv_files.size != 2
      end
    end
  end
end
