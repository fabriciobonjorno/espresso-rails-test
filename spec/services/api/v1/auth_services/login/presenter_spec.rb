# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthServices::Login::Presenter do
  describe '#call' do
    it 'returns a hash with CSRF, access_token, and refresh_token' do
      presenter = described_class.new
      token = { csrf: 'csrf_token', access: 'access_token', refresh: 'refresh_token' }

      result = presenter.call(token)

      expect(result).to include(
        csrf: 'csrf_token',
        access_token: 'access_token',
        refresh_token: 'refresh_token'
      )
    end
  end
end
