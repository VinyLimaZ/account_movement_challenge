require_relative "#{Dir.pwd}/services/csv/sanitize_files"
require 'csv'

describe Services::CSV::SanitizeFiles do
  subject { described_class.call(csv_files) }

  describe '.call' do
    context 'with a valid CSV file' do
      let(:csv_files) { [CSV.open("#{CSV_FIXTURE_DIR}/acc_valid.csv")] }
      let(:csv_array) { [[1, 100], [3, 1000]] }

      it { is_expected.to match(csv_array) }
    end

    context 'with an invalid CSV file' do
      let(:csv_files) { [CSV.open("#{CSV_FIXTURE_DIR}/acc_invalid.csv")] }
      let(:csv_array) { [[1,100], [1,1000]] }

      it 'remove inconsistent input data' do
        is_expected.to match(csv_array)
      end
    end
  end
end
