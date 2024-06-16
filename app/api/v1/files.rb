# frozen_string_literal: true

module V1
  class Files < Grape::API
    before { authenticate_user! }

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
        present files, with: ::Entities::FileResource, domain: request.base_url
      end

      desc "Upload a file" do
        success type: Hash do
          property :link, type: String, desc: "URL to the zipped file"
          property :password, type: String, desc: "Password for the zipped file"
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
        file = params[:file]
        result = SecureZipService.new(user: current_user, file:).call

        return handle_error(result.error) unless result.success?

        base_url = request.base_url.to_s
        file_url = File.join(base_url, result.value[:zipfile_path])

        { link: file_url, password: result.value[:password] }
      end
    end
  end
end
