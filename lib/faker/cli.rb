require "faker/cli/version"

require 'pry'
require 'pry-byebug'
require 'json'
require 'faker'

require 'optparse'

module Faker
  module Cli
    class Field
      attr_accessor :name, :type, :arguments

      def initialize name, type, arguments
        @name, @type = name, type
        @arguments = arguments.map { |arg| Faker::Cli.int? arg }
      end
    end

    class OptParse
      DEFAULT_NUM = 10

      class << self
        attr_reader :parser
      end

      @@options = {}

      @parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] DEF1 DEF2 ... DEFN"
        opts.separator ""

        opts.separator "Definitions:"

        opts.separator ""
        opts.separator "Options:"

        opts.on "-n", "--num-entries [NUM]", Integer,
          "Number of entries. Defaults to #{DEFAULT_NUM}" do |num|
          @@options[:numentries] = num
        end
      end

      def self.parse args
        @parser.parse!(args)
        @@options
      end
    end

    def self.run
      options = OptParse.parse ARGV
      options[:numentries] = OptParse::DEFAULT_NUM unless options.has_key? :numentries

      if ARGV.length < 1 then
        puts OptParse::parser.help
        exit
      end

      puts generate options
    end

    def self.make_fields
      ARGV.map do |arg|
        p = arg.split ":"
        p << "Lorem.word" if p.length == 1

        name = p[0]
        type = p[1].match(/^[^\(\)]+/).to_s.split "."

        argmatch = p[1].match(/\(([^\)]+)\)/)
        args = []
        args = argmatch[1].split(/,\s+/) if argmatch

        Field.new(name, type, args)
      end
    end

    def self.generate options
      JSON.generate generate_result options[:numentries], make_fields
    end

    def self.generate_result num, fields
      result = num.times.map do |n|
        obj = {}

        fields.each do |field|
          faker_module = Faker.const_get field.type[0]
          fake = faker_module.send(field.type[1], *field.arguments)
          obj[field.name] = string? int? fake
        end

        obj
      end
    end

    def self.int? arg
      begin
        arg = Integer arg
      rescue ArgumentError, TypeError
      end

      arg
    end

    def self.string? arg
      arg = arg.join " " if arg.is_a? Array
      arg
    end
  end
end
