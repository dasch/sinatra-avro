require 'sinatra/test_helpers'
require 'json'

describe Sinatra::Avro do
  include Sinatra::TestHelpers

  before do
    mock_app do
      set :avro_schema_dir, "spec/"
      get '/' do
        data = { "name" => "Jane", "age" => 42 }
        avro data, schema_name: "person"
      end
    end
  end

  it "allows serializing data using Avro" do
    avro = get('/').body
    expect(avro_decode(avro)).to eq("name" => "Jane", "age" => 42)
  end

  it "sets the Content-Type header to avro/binary" do
    response = get('/')
    expect(response["Content-Type"]).to eq "avro/binary; schema=person"
  end

  def avro_decode(avro)
    reader = Avro::DataFile::Reader.new(StringIO.new(avro), Avro::IO::DatumReader.new)
    data = reader.first
  end
end
