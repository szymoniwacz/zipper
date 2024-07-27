FactoryBot.define do
  factory :file_archive do
    association :user
    file_path { Rails.root.join('tmp', 'testfile.txt').to_s }
    zipfile_path { nil }
    password { SecureRandom.hex(10) }
    status { 'processing' }
    error { nil }
  end
end
