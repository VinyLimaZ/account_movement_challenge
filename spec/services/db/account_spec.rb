require_relative "#{ROOT_DIR}/services/db/account"

describe Services::DB::Account do
  describe '.upsert_all' do
    before { described_class.upsert_all(rows) }
    let(:rows) { [[1, 100], [2,200], [3,100], [3,500]] }

    it 'saves on DB the account and balance information' do
      expect(described_class.get(1).balance).to eq 100
      expect(described_class.get(2).balance).to eq 200
    end

    it 'overwrite the balance if account is on 2 or more rows' do
      expect(described_class.get(3).balance).to eq 500
    end
  end

  describe '.upsert' do
    subject { described_class.upsert(row_hash) }
    let(:account_db) { described_class.accounts_db }

    context 'if account not exist' do
      let(:row_hash) { { id: 1, balance: 100 } }

      it 'creates a new one' do
        expect { subject }.to change { account_db.count }.from(0).to(1)
      end
    end

    context 'if account already exists' do
      before { described_class.upsert(id: 1, balance: 200) }
      let(:row_hash) { { id: 1, balance: 500 } }

      it 'updates to the new value' do
        expect { subject }.to change { described_class[1].balance }.from(200).to(500)
      end
    end
  end
end
