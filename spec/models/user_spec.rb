# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  # tests go here
  subject { create(:user) }

  before { subject.save }

  it 'should be an admin' do
    expect(subject.admin?).to eq(true)
  end
end
