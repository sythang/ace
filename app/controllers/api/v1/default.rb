module API
  module V1
    class Default < Grape::API
      def self.inherited(subclass)
        super
        subclass.instance_eval do
          helpers do
            def permitted_params
              @permitted_params ||= declared(params, include_missing: false)
            end

            def logger
              Rails.logger
            end

            def authorize_api!
              error!({ message: 'Unauthorized. Invalid token.', code: 'invalid_token', messages: [], with: API::V1::Entities::Error }, 401) unless current_user
            end

            def current_user
              token = request.headers['Http-Auth-Token'] || request.headers['Auth-Token'] || params[:api_token]
              if token.present?
                @current_user ||= User.student.where(api_token: token).first
              else
                false
              end
            end
            params :pagination do
              optional :page, type: Integer, desc: 'Page'
              optional :per_page, type: Integer, desc: 'Per page'
            end
          end

          rescue_from ActiveRecord::RecordNotFound do |e|
            error!({ message: e.message, code: 'record_not_found', with: API::V1::Entities::Error }, 404)
          end

          rescue_from ActiveRecord::RecordInvalid do |e|
            error!({ message: e.message, code: 'record_invalid', with: API::V1::Entities::Error }, 422)
          end

          rescue_from Grape::Exceptions::ValidationErrors do |e|
            error!({ messages: e.full_messages, message: e.full_messages[0], code: 'validation_error', with: API::V1::Entities::Error }, 400)
          end
        end
      end
      

    end
  end
end