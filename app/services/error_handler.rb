# frozen_string_literal: true

module ErrorHandler
  def handle_error(error)
    Rails.logger.error("An error occurred: #{error.message}")
    Result.failure(error.message)
  end
end
