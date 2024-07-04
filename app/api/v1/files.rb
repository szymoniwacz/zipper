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
        result = SecureZipService.new(user: current_user, file: params[:file], base_url: request.base_url).call

        return result.value if result.success?

        error!(result.error, 422)
      end
    end
  end
end
