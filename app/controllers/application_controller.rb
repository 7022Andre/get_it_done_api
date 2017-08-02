class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render json: { message: "Entry not found." }, status: 404
  end

  def not_authorized
    render json: { message: "You're not authorized to do this." }, status: 403
  end

  def private_list

  end
end
