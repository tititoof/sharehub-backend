# frozen_string_literal: true

module V1
  module Users
    # Manage profiles for current_user logged by jwt
    class ProfilesController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!

      # return Profile serialized
      def index
        @resource = V1::Users::Profiles::ShowService.call(current_user)

        serializer_response(::Users::ProfileSerializer)
      end

      def show
        @resource = { success: true, payload: ::Users::Profile.find(params[:profile_id]) }

        serializer_response(::Users::ProfileSerializer)
      rescue ActiveRecord::RecordNotFound => _e
        render json: { error: :recordNotFound }, status: :unprocessable_entity
      end

      def show_avatar
        redirect_to rails_blob_url(current_user.profile.avatar)
      end

      def list
        @resource = { success: true, payload: ::Users::Profile.all }

        serializer_response(::Users::ProfileSerializer)
      end

      def save
        @resource = V1::Users::Profiles::SaveProcedure.call(current_user, profile_params)

        serializer_response(::Users::ProfileSerializer)
      end

      def upload_avatar
        @resource = V1::Users::Profiles::UploadAvatarService.call(current_user, profile_params[:avatar])

        serializer_response(::Users::ProfileSerializer)
      end

      private

      def profile_params
        params.required(:profile).permit(:address, :date_of_birth, :email, :first_name,
                                         :last_name, :nickname, :phone, :city_id, :user_id,
                                         :avatar)
      end
    end
  end
end
