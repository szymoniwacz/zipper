module V1
  class FileArchives < Grape::API
    before { authenticate_user! }

    resource :file_archives do
      desc "Check file archive status" do
        success type: Hash do
          property :status, type: String, desc: "Status of the file archive"
          property :link, type: String, desc: "URL to the zipped file", nullable: true
          property :password, type: String, desc: "Password for the zipped file", nullable: true
          property :error, type: String, desc: "Error message if any", nullable: true
        end
        headers "Authorization" => {
          description: "Bearer token",
          required: true
        }
      end
      params do
        requires :id, type: Integer, desc: "File archive ID"
      end
      get ':id' do
        file_archive = FileArchive.find(params[:id])

        {
          status: file_archive.status,
          link: file_archive.zipfile_path,
          password: file_archive.password,
          error: file_archive.error
        }
      end
    end
  end
end
