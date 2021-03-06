require_relative "#{ROOT_DIR}/services/csv/sanitize_file"
require 'csv'

describe Services::CSV::SanitizeFile do
  subject { described_class.call(csv_files) }

  describe '.call' do
    context 'with a valid CSV file' do
      let(:csv_files) { CSV.open("#{CSV_FIXTURE_DIR}/acc_valid.csv") }
      let(:csv_array) { [[1, 100], [2, 0], [3, 1000], [4, -3000]] }

      it { is_expected.to match(csv_array) }
    end

    context 'with an invalid CSV file' do
      let(:csv_files) { CSV.open("#{CSV_FIXTURE_DIR}/acc_invalid.csv") }
      let(:csv_array) { [[1, 0], [1,100], [1,1000], [2, -44]] }

      it 'remove inconsistent input data' do
        is_expected.to match(csv_array)
      end
    end
  end
end
