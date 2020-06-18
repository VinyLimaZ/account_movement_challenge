require_relative "#{Dir.pwd}/app/concerns/errors"

module Services
  module CSV
    class SanitizeFile
      include Errors

      def self.call(csv_file)
        new.call(csv_file)
      end

      def initialize; end

      def call(csv_file)
        p wrong_file_type_error and exit_app if csv_file.class != ::CSV
        sanitize_file(csv_file.read)
      end

      private
      def sanitize_file(csv_array)
        csv_array = remove_excess_cells(csv_array)
        csv_array = parse_to_int(csv_array)
        remove_empty_rows(csv_array)
      end

      def parse_to_int(csv_array)
        csv_array.map do |row|
          row.map(&:to_i)
        end
      end

      def remove_excess_cells(csv_array)
        csv_array.select do |row|
          row.size == 2 ? row : [row[0], row[1]]
        end
      end

      def remove_empty_rows(csv_array)
        csv_array.delete_if do |row|
          invalid_row?(row) ||
            invalid_cell?(row)
        end
      end


      def invalid_row?(row)
        row.empty?
      end

      def invalid_cell?(row)
        row[0] < 1
      end
    end
  end
end
