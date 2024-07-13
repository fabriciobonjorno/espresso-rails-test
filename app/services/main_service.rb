# frozen_string_literal: true

class MainService
  include Dry::Transaction

  def self.call(...)
    new.call(...)
  end
end
