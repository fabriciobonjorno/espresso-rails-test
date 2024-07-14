# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card do
  subject { build(:card) }

  it { is_expected.to validate_presence_of(:last4) }
  it { is_expected.to belong_to(:user) }
end
