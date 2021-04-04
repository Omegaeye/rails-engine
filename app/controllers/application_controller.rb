class ApplicationController < ActionController::API
  include ActionController::Helpers
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: 404
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def pagination_helper(class_arg)
    params[:page] = 1 if params[:page].to_i < 1 || !params[:page]
    params[:per_page] = 20 if params[:per_page].to_i < 1 || !params[:per_page]
    offset = ((params[:page].to_i - 1) * params[:per_page].to_i)
    class_arg.offset(offset).limit(params[:per_page])
  end

  helper_method :pagination_helper
end
