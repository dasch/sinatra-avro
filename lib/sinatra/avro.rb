require 'sinatra/avro/version'
require 'sinatra/base'
require 'avro'

module Sinatra
  module Avro
    MIME_TYPE = "avro/binary".freeze

    def avro(object, options = {})
      schema_json = options.fetch(:schema) { raise "please pass a schema" }
      schema = ::Avro::Schema.parse(schema_json)
      writer = ::Avro::IO::DatumWriter.new(schema)
      io = StringIO.new

      dw = ::Avro::DataFile::Writer.new(io, writer, schema)
      dw << object.to_h
      dw.close

      # Set the Content-Type response header.
      content_type MIME_TYPE

      io.string
    end
  end

  Base.helpers Avro
end
