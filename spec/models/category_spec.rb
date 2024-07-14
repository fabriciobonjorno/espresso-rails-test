# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  subject { build(:category) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:company) }
end
