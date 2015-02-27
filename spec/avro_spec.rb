require 'sinatra/test_helpers'
require 'json'

describe Sinatra::Avro do
  include Sinatra::TestHelpers

  SCHEMA = {
    type: "record",
    name: "person",
    fields: [
      { name: "name", type: "string" },
      { name: "age", type: "long" },
    ]
  }.to_json


  it "allows serializing responses with Avro" do
    mock_app do
      get '/' do
        data = { "name" => "Jane", "age" => 42 }
        avro data, schema: SCHEMA
      end
    end

    expect(decoded_data).to eq("name" => "Jane", "age" => 42)
  end

  it "sets the Content-Type header to avro/binary" do
    mock_app do
      get '/' do
        data = { "name" => "Jane", "age" => 42 }
        avro data, schema: SCHEMA
      end
    end

    response = get('/')
    expect(response["Content-Type"]).to eq "avro/binary"
  end

  def decoded_data
    avro = get('/').body
    reader = Avro::DataFile::Reader.new(StringIO.new(avro), Avro::IO::DatumReader.new)
    data = reader.first
  end
end
