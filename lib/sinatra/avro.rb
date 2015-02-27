require 'sinatra/avro/version'
require 'sinatra/base'
require 'avro'

module Sinatra
  module Avro
    MIME_TYPE = "avro/binary".freeze

    def avro(object, options = {})
      schema_json = fetch_avro_schema(options)

      # Set the Content-Type response header.
      content_type MIME_TYPE

      avro_encode(object, schema_json)
    end

    def avro_encode(object, schema_json)
      schema = ::Avro::Schema.parse(schema_json)
      writer = ::Avro::IO::DatumWriter.new(schema)
      io = StringIO.new

      dw = ::Avro::DataFile::Writer.new(io, writer, schema)
      dw << object.to_h
      dw.close

      io.string
    end

    def fetch_avro_schema(options = {})
      options[:schema] || load_avro_schema(options.fetch(:schema_name))
    end

    def load_avro_schema(schema_name)
      schema_path = File.join(settings.avro_schema_dir, schema_name + ".avsc")

      File.read(schema_path)
    end
  end

  Base.set :avro_schema_dir, "schemas"
  Base.helpers Avro
end
