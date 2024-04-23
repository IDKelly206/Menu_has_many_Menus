module FormHelper
  def form_errors_for(attrs = { })
    obj = attrs[:obj]
    v = attrs[:value].to_sym

    if obj.errors.messages[v].present?
      render 'shared/form_errors', msg: obj.errors.messages[v].join(",\n" + ".")
      # message = obj.errors.messages[v].join(",\n" + ".")
    else
      nil
    end

  #   obj.errors.attribute_names.each_with_index do |name, i|
  #     messages[:name] = obj.errors.full_messages[i] + "."
  #   end
    # unless message.empty?
    #   render 'shared/form_errors', msg: message
    # end
  end
end
