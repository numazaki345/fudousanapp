class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def snake_case_params
    @snake_case_params ||= params.deep_transform_keys!(&:underscore)
  end
end
