module ParametersHelper
  def present_parameters?(params, requeridos)
    requeridos.all? { |param| params[param].present? }
  end
end
