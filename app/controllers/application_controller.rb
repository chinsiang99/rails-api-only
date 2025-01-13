class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  private

  def not_destroyed(e)
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  def not_found
    render json: { error: "Record not found" }, status: :not_found
  end

  def handle_parameter_missing(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
