# frozen_string_literal: true

module V1
  class Files < Grape::API
    before { authenticate_user! }

    helpers do
      def present_files(files)
        present files, with: ::Entities::FileResource, domain: request.base_url
      end
    end

    resource :files do
      desc "List files of the current user" do
        success Entities::FileResource
        headers "Authorization" => {
          description: "Bearer token",
          required: true
        }
      end

      get do
        files = current_user.file_resources
        present_files(files)
      end

      desc "Upload a file" do
        success type: Hash do
          property :status, type: String, desc: "Status of the file archive"
          property :link, type: String, desc: "URL to the zipped file", nullable: true
          property :password, type: String, desc: "Password for the zipped file", nullable: true
          property :error, type: String, desc: "Error message if any", nullable: true
          property :archive_url, type: String, desc: "URL to check the status of the file archive"
        end
        consumes "multipart/form-data"
        headers "Authorization" => {
          description: "Bearer token",
          required: true
        }
      end
      params do
        requires :file, type: File, desc: "File to upload"
      end
      post do
        uploaded_file = params[:file]
        result = CreateFileArchiveService.new(file: uploaded_file, user: current_user).call

        return error!(result.error, 422) unless result.success?

        file_archive = result.value
        SecureZipServiceWorker.perform_async(file_archive.id)
        archive_url = "#{request.base_url}/api/v1/file_archives/#{file_archive.id}"

        { status: 'processing', link: nil, password: nil, archive_url: archive_url }
      end
    end
  end
end
