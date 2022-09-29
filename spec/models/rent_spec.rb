require 'rails_helper'

RSpec.describe Rent, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  subject { Rent.new(state: :approved, item: item, user: user,
                         begin: DateTime.new(2022, 1, 10),
                         end: DateTime.new(2022, 1, 15),
                         number: 5) }
  before(:each) do
    Timecop.freeze(DateTime.new(2022, 1, 1))
  end

  after do
    Timecop.return
  end
  it 'is valid when another rent will be taken after the end' do
    Rent.create!(state: :approved, item: item, user: user,
                 begin: DateTime.new(2022, 1, 16),
                 end: DateTime.new(2022, 1, 17),
                 number: 5)
    expect(subject).to be_valid
  end

  it 'is invalid when another rent ends at the same day' do
    Rent.create!(state: :approved, item: item, user: user,
                begin: DateTime.new(2022, 1, 5),
                end: DateTime.new(2022, 1, 10),
                number: 5)
    expect(subject).not_to be_valid
  end
  it 'is invalid when another rent begins at the same day' do
    Rent.create!(state: :approved, item: item, user: user,
                 begin: DateTime.new(2022, 1, 15),
                 end: DateTime.new(2022, 1, 16),
                 number: 5)
    expect(subject).not_to be_valid
  end
  it 'is invaild when another rent is at the same time' do
    Rent.create!(state: :approved, item: item, user: user,
                 begin: DateTime.new(2022, 1, 10),
                 end: DateTime.new(2022, 1, 15),
                 number: 5)
    expect(subject).not_to be_valid
  end
  it 'when another rent is begins before and ends after thisone' do
    Rent.create!(state: :approved, item: item, user: user,
                 begin: DateTime.new(2022, 1, 9),
                 end: DateTime.new(2022, 1, 16),
                 number: 5)
    expect(subject).not_to be_valid
  end
end
