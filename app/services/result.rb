# frozen_string_literal: true

class Result
  attr_accessor :value, :error

  def self.success(value)
    new(value:)
  end

  def self.failure(error)
    new(error:)
  end

  def initialize(value: nil, error: nil)
    @value = value
    @error = error
  end

  def map
    return self unless success?

    @value = yield(value)
    self
  rescue StandardError => e
    Result.failure(e)
  end

  def success?
    error.nil?
  end

  def failure?
    !success?
  end

  def rescue
    yield(error) if failure?
    self
  end
end
