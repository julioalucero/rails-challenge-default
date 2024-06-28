ActiveModelSerializers.config.tap do |config|
  config.adapter = :json # Ensure you're using JSON adapter
  config.jsonapi_include_toplevel_object = true # Include top-level object
end
