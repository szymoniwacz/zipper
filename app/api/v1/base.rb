# frozen_string_literal: true

module V1
  class Base < Grape::API
    use Warden::Manager

    version "v1", using: :path

    helpers do
      def authenticate_user!
        error!("Unauthorized", 401) unless current_user
      end

      def current_user
        @current_user ||= env["warden"].authenticate(scope: :user)
      end

      def handle_error(error)
        # TODO: Add more error info like user id, file name.
        Rails.logger.error("An error occurred while archiving file: #{error.message}")
        { error: error.message }
      end

      def handle_error(error)
        # TODO: Add more error info like user id, file name.
        Rails.logger.error("An error occurred while archiving file: #{error.message}")
        { error: error.message }
      end

      def handle_error(error)
        # TODO: Add more error info like user id, file name.
        Rails.logger.error("An error occurred while archiving file: #{error.message}")
        { error: error.message }
      end
    end

    mount V1::Users
    mount V1::Files

    add_swagger_documentation(
      api_version: "v1",
      base_path: "/api",
      mount_path: "/swagger_doc",
      hide_documentation_path: true,
      hide_format: true,
      format: :json,
      info: {
        title: "Zipper API V1",
        description: "API documentation for the Files endpoint"
      },
      models: [Entities::FileResource]
    )
  end
end
