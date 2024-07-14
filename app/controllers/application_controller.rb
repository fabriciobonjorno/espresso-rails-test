# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JwtSession
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
end
