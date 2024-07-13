# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject { build(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password).ignoring_interference_by_writer }
  it { is_expected.to validate_presence_of(:password_confirmation).ignoring_interference_by_writer }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to belong_to(:company) }

  it 'validates email format' do
    user = build(:user, email: 'invalid_email')
    user.validate
    expect(user.errors[:email]).to include('is invalid')
  end

  it 'validates password confirmation' do
    user = build(:user, password: 'password', password_confirmation: 'different_password')
    user.validate
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end
end
