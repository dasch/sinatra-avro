# Sinatra::Avro

A Sinatra plugin that allows encoding requests and responses using Apache Avro.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-avro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-avro

## Usage

Add an Avro schema to e.g. `schemas/person.avsc`:

```json
{
  "name": "person",
  "type": "record",
  "fields": [
    { "name": "name", "type": "string" },
    { "name": "age", "type": "long" }
  ]
}
```

You can now respond with Avro encoded data:

```ruby
get '/' do
  # Will use the schema defined by `./schemas/person.avsc`.
  avro({ "name" => "Jane", "age" => 42 }, schema_name: "person")
end
```

You can configure which directory to look up schema files from using

```ruby
set :avro_schema_dir, "some/other/dir"
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/sinatra-avro/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
