# frozen_string_literal: true

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_access_request!
  before_action :set_current_user

  private

  def set_current_user
    Current.set(current_user)
  end
end
