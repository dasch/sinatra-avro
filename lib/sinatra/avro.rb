require 'sinatra/avro/version'
require 'sinatra/base'
require 'avro'

module Sinatra
  module Avro
    def avro(object, options = {})
      schema_json = options.fetch(:schema) { raise "please pass a schema" }
      schema = ::Avro::Schema.parse(schema_json)
      writer = ::Avro::IO::DatumWriter.new(schema)
      io = StringIO.new

      dw = ::Avro::DataFile::Writer.new(io, writer, schema)
      dw << object.to_h
      dw.close

      io.string
    end
  end

  Base.helpers Avro
end
