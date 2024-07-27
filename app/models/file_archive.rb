class FileArchive < ApplicationRecord
  belongs_to :user

  before_create :generate_secure_password

  private

  def generate_secure_password
    self.password = SecureRandom.hex(10)
  end
end
