require 'sinatra/avro/version'
require 'sinatra/base'
require 'avro_turf'

module Sinatra
  module Avro
    def avro(object, options = {})
      schema_name = options.fetch(:schema_name) { raise "Please specify a schema name" }
      full_schema_name = ::Avro::Name.make_fullname(schema_name, settings.avro_namespace)

      # Set the Content-Type response header.
      content_type "avro/binary; schema=#{full_schema_name}"

      avro_encode(object, options)
    end

    private

    def avro_encode(object, schema_name:)
      @avro ||= AvroTurf.new(schemas_path: settings.avro_schema_dir, namespace: settings.avro_namespace)
      @avro.encode(object, schema_name: schema_name)
    end
  end

  Base.set :avro_schema_dir, "schemas"
  Base.set :avro_namespace, nil
  Base.helpers Avro
end
