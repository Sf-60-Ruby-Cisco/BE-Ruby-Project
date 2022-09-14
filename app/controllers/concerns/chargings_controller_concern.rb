require "active_support/concern"

module ChargingsControllerConcern
  extend ActiveSupport::Concern
  
  def stream_form_errors_and_error_message(record, form_for, form, error_message)
    return [
      turbo_stream.replace(
        "#{helpers.dom_id(record)}_form", 
        partial: form, 
        locals: { car: @car, form_for => record }
      ),
      turbo_stream.replace(
        "messagesContainer", 
        partial: "layouts/flash", 
        locals: { flash: {error: error_message } }
      )
    ]
  end
end