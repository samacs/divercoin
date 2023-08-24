RSpec.shared_examples_for 'sessionable' do
  describe 'inheritance' do
    subject { described_class }

    it { is_expected.to be <= Sessionable }
  end

  describe 'attributes' do
    it { is_expected.to have_attribute(:current_sign_in_at) }
    it { is_expected.to have_attribute(:current_sign_in_ip) }
    it { is_expected.to have_attribute(:last_sign_in_at) }
    it { is_expected.to have_attribute(:last_sign_in_ip) }
  end

  describe 'methods' do
    subject(:sessionable) { described_class.new }

    let(:ip) { '192.168.0.123' }
    let(:now) { Time.current }

    before { Timecop.freeze(now) }

    describe '#sign_in!' do
      its(:current_sign_in_ip) { is_expected.to be_nil }
      its(:current_sign_in_at) { is_expected.to be_nil }

      context 'when called' do
        before { sessionable.sign_in!(ip) }

        its(:current_sign_in_ip) { is_expected.to eq ip }
        its(:current_sign_in_at) { is_expected.to be_within(1.second).of(now) }
      end
    end

    describe '#sign_out!' do
      before { sessionable.sign_in!(ip) }

      its(:last_sign_in_at) { is_expected.to be_nil }
      its(:last_sign_in_ip) { is_expected.to be_nil }

      context 'when called' do
        let(:future) { now + 5.hours }

        before do
          Timecop.travel(future)

          sessionable.sign_out!
        end

        its(:current_sign_in_ip) { is_expected.to be_nil }
        its(:current_sign_in_at) { is_expected.to be_nil }
        its(:last_sign_in_ip) { is_expected.to eq ip }
        its(:last_sign_in_at) { is_expected.to be_within(1.second).of(now) }
      end
    end
  end
end
