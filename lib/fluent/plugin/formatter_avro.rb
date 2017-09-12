require 'avro'

module Fluent
  module TextFormatter
    class AvroFormatter < Formatter
      MAGIC_BYTE = [0].pack("C").freeze
      Fluent::Plugin.register_formatter('avro', self)

      config_param :schema, :string, :default => nil,
                   :desc => "avro schema"
      config_param :file, :bool, :default => false,
                   :desc => "set to true if loading schema from file"
      config_param :schema_id, :integer, :default => 1,
                   :desc => "avro schema id"
      def configure(conf)
        super
        if @file == true then
          @schema = File.read(@schema)
        end
        @schema = Avro::Schema.parse(@schema)
      end

      def format(tag, time, record)
        writer = Avro::IO::DatumWriter.new(@schema)
        buffer = StringIO.new
        encoder = Avro::IO::BinaryEncoder.new(buffer)
        encoder.write(MAGIC_BYTE)
        encoder.write([@schema_id].pack("N"))
        writer.write(record, encoder)
        buffer.string
      end
    end
  end
end