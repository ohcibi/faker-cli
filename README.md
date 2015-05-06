# Faker::Cli

This tool uses [Faker](https://github.com/stympy/faker) to generate a json
array of json objects with special fields and faked values.

## Installation

Add this line to your application's Gemfile:

    gem 'faker-cli'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faker-cli

## Usage

    faker-cli [-n NUM-ENTRIES] DEF1 DEF2 ... DEFN

The value for `-n` defaults to 10. The above command will create `-n` entries
with fields defined by `DEF1` to `DEFN`.

### DEF

A DEF has the form

    <name>:<Faker-Module>.<Faker-Method>

or

    <name>:<Faker-Module>.<Faker-Method>(param1, param2)

* `name` is the name of the objects key
* `Faker-Module` is the name of the [Faker](https://github.com/stympy/faker) module (e.g. `Lorem`)
* `Faker-Method` is the method of that module (e.g. `word`)

The string after the `:` is basically "applied" to the [Faker](https://github.com/stympy/faker) module.
So `id:Number.positive` would actually call `Faker::Number.positive()` to
generate an `id`-field for one entry.

#### Other DEFs:

    "id:Number.positive(5, 100)"
    "text:Lorem.words(5)"
    "created_at:Date.forward"

### Usage Examples

    faker-cli 50 "id:Number.positive"\
      "filename:Lorem.words(2)"\
      "filesize:Number.between(150, 700)"\
      "created_at:Date.backward"\
      "modified_at:Date.backward"\
      "directory_id:Number.positive(2, 6)"

Will output a json array of 50 json objects that look like:

```json
{
    "id": 1136,
    "filename": "rem necessitatibus",
    "filesize": 300,
    "directory_id": 4,
    "created_at": "2013-09-25",
    "modified_at": "2014-07-14"
}
```

## Contributing

1. Fork it ( https://github.com/ohcibi/faker-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
