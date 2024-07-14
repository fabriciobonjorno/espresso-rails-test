# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JwtSession
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  before_action :set_current_user

  private

  def set_current_user
    Current.set(current_user)
  end
end
