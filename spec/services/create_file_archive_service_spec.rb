# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateFileArchiveService do
  let(:user) { create(:user) }
  let(:file) do
    {
      filename: 'test.txt',
      tempfile: Tempfile.new('test')
    }
  end

  describe '#call' do
    context 'when the service is successful' do
      it 'saves the file and creates a file archive' do
        service = CreateFileArchiveService.new(file: file, user: user)
        result = service.call

        expect(result).to be_success
        file_archive = result.value
        expect(file_archive).to be_persisted
        expect(file_archive.user).to eq(user)
        expect(file_archive.file_path).to include('tmp')
        expect(file_archive.status).to eq('processing')

        # Clean up the created file
        File.delete(file_archive.file_path) if File.exist?(file_archive.file_path)
      end
    end

    context 'when there is an error' do
      before do
        allow_any_instance_of(CreateFileArchiveService).to receive(:save_file).and_raise("Failed to save file: Test error")
      end

      it 'handles the error and returns a failure result' do
        service = CreateFileArchiveService.new(file: file, user: user)
        result = service.call

        expect(result).not_to be_success
        expect(result.error.message).to eq('Failed to save file: Test error')
      end
    end
  end
end
