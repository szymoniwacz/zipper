# frozen_string_literal: true

module V1
  class Files < Grape::API
    before { authenticate_user! }

    resource :files do
      desc "List files of the current user"
      get do
        files = current_user.file_resources
        present files, with: ::Entities::FileResource, domain: request.base_url
      end

      desc "Upload a file"
      params do
        requires :file, type: File
      end
      post do
        file = params[:file]
        result = SecureZipService.new(user: current_user, file: file).call

        return handle_error(result.error) unless result.success?

        base_url = request.base_url.to_s
        file_url = File.join(base_url, result.value[:zipfile_path])

        { link: file_url, password: result.value[:password] }
      end
    end
  end
end
