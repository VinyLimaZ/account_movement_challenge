require_relative "#{ROOT_DIR}/services/calculate/transactions"
require_relative "#{ROOT_DIR}/services/db/account"

describe Services::Calculate::Transactions do
  describe '.update_all' do
    let(:account_class) { Services::DB::Account }

    before do
      account_class.upsert_all([[1, 10000], [2, 0], [3, -30000 ]])
    end

    describe 'if the transaction is a credit' do
      before { described_class.update_all(transaction) }
      let(:transaction) { [[3, 10000]] }
      let(:account_id) { 3 }
      let(:account) { account_class.get(account_id) }

      it 'adds value to the account' do
        expect(account.balance).to eq -20000
      end
    end

    describe 'if the transaction is a debit' do
      before { described_class.update_all(transaction) }
      let(:account_id) { 1 }
      let(:account) { account_class.get(account_id) }

      context 'and makes the account balance negative' do
        let(:transaction) { [[1, -20000]] }

        it 'adds a bank fine of 300 per transaction' do
          expect(account.balance).to eq -10300
        end
      end

      context 'and not makes the account balance negative' do
        let(:transaction) { [[1, -10000]] }
        it 'only decreases the balance' do
          expect(account.balance).to eq 0
        end
      end
    end
  end
end
