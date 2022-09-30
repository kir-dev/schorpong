require 'rails_helper'

RSpec.describe Rent, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:pre_existing_rent) do
    Rent.create!(state: :approved, item: item, user: user,
                 begin: DateTime.new(2022, 1, 10),
                 end: DateTime.new(2022, 1, 15),
                 number: 5)
  end
  let(:current_rent) do
    Rent.new(state: :approved, item: item, user: user,
             begin: begin_date,
             end: end_date,
             number: 5)
  end

  subject do
    pre_existing_rent
    current_rent
  end

  before(:each) do
    Timecop.freeze(DateTime.new(2022, 1, 1))
  end

  after do
    Timecop.return
  end

  context 'when the rent starts before the pre existing rent' do
    let(:begin_date) { DateTime.new(2022, 1, 5) }
    context 'and ends before the current rent' do
      let(:end_date) { DateTime.new(2022, 1, 9) }
      it { expect(subject).to be_valid }
    end
    context 'and ends on the current rent beginning date' do
      let(:end_date) { DateTime.new(2022, 1, 10) }
      it { expect(subject).to be_valid }
    end
    context 'and ends after the current_rent is take' do
      let(:end_date) { DateTime.new(2022, 1, 11) }
      it { expect(subject).not_to be_valid }
    end
  end

  context 'when the rent ends after the pre existing rent' do
    let(:end_date) { DateTime.new(2022, 1, 20) }
    context 'and begins before the current rent is back' do
      let(:begin_date) { DateTime.new(2022, 1, 14) }
      it { expect(subject).not_to be_valid }
    end
    context 'and begins whe the current rent is back' do
      let(:begin_date) { DateTime.new(2022, 1, 15) }
      it { expect(subject).to be_valid }
    end
    context 'and begins after the current rent is back' do
      let(:begin_date) { DateTime.new(2022, 1, 16) }
      it { expect(subject).to be_valid }
    end
  end
end
