require_relative "#{Dir.pwd}/services/csv/open_files"

describe Services::CSV::OpenFiles do
  describe '#csv_files' do
    let(:file_paths) { ["#{CSV_FIXTURE_DIR}/acc_valid.csv", "#{CSV_FIXTURE_DIR}/trans_valid.csv"] }

    context 'returns two csv files' do
      let(:files_array) { file_paths.map { |file_path| File.open(file_path) } }
      subject { described_class.call(file_paths) }

      it 'Returns two CSV objects' do
        expect(subject.count).to eq 2
      end

      it 'Returns a CSV object' do
        expect(subject.first.class).to eq CSV
      end
    end

    describe 'halt the app if' do
      subject { described_class.call(file_path) }

      context 'if dont find 2 files' do
        let(:file_path) { [file_paths[0]] }

        it { expect { subject }.to raise_error SystemExit }
      end

      context 'if finds path problem' do
        let(:file_path) { ["FILENOTFOUND.csv", "FILENOTFOUND2.csv"] }

        it { expect { subject }.to raise_error SystemExit }
      end
    end
  end
end
