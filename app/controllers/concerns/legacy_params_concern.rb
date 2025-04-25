# This module provides backward compatibility for controllers
# that may still be using params[:model] directly instead of strong parameters

module LegacyParamsConcern
  extend ActiveSupport::Concern

  # Helper method to handle legacy parameter access patterns
  def legacy_params(model_name, allowed_attributes)
    if params[model_name].respond_to?(:permit)
      # Already using strong parameters format
      params.require(model_name).permit(*allowed_attributes)
    else
      # Legacy format, transform to strong parameters
      ActionController::Parameters.new(model_name => params[model_name]).
        require(model_name).permit(*allowed_attributes)
    end
  end
end