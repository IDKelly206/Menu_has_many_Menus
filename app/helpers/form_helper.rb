module FormHelper
  def form_errors_for(attrs = { })
    obj = attrs[:obj]
    input = attrs[:value]
    v = input.to_sym

    if obj.errors.messages[v].present?
      obj.errors.messages[v].join("#{input.capitalize}" + ",\n" + ".")

    else
      nil
    end
  end
end
