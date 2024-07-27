class SecureZipServiceWorker
  include Sidekiq::Worker

  def perform(file_archive_id)
    SecureZipService.new(file_archive_id: file_archive_id).call
  end
end
