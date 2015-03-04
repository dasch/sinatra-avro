require 'sinatra/avro/version'
require 'sinatra/base'
require 'avro_turf'

module Sinatra
  module Avro
    MIME_TYPE = "avro/binary".freeze

    def avro(object, options = {})
      # Set the Content-Type response header.
      content_type MIME_TYPE

      avro_encode(object, options)
    end

    private

    def avro_encode(object, options)
      schema_name = options.fetch(:schema_name) { raise "Please specify a schema name" }
      @avro ||= AvroTurf.new(schemas_path: settings.avro_schema_dir)
      @avro.encode(object, schema_name: schema_name)
    end
  end

  Base.set :avro_schema_dir, "schemas"
  Base.helpers Avro
end
