class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def render_failed(messages = ['验证失败'])
    render json: { errors: messages}, status: :unauthorized
  end
end
