# frozen_string_literal: true

class Result
  attr_accessor :value, :error

  def initialize(value = nil, error = nil)
    @value = value
    @error = error
  end

  def map
    return self if error

    begin
      self.value = yield(value)
      self
    rescue StandardError => e
      Result.new(nil, e)
    end
  end

  def success?
    error.nil?
  end

  def failure?
    !success?
  end

  def rescue
    return self unless error

    begin
      self.error = error
      self
    rescue StandardError => e
      Result.new(nil, e)
    end
  end
end
