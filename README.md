# fluent-plugin-avro

[![Build Status](https://travis-ci.org/takebayashi/fluent-plugin-avro.svg)](https://travis-ci.org/takebayashi/fluent-plugin-avro)

fluent-plugin-avro provides a formatter plugin for Fluentd.

## Configurations

Either `file` or `schema` is required.

| Name | Description |
| ---- | ----------- |
| `file` | filename of Avro schema |
| `schema` | JSON representation of Avro schema |
| `schema_id` | the Avro schema id |

### Example

```
<match example.avro>
  type file
  path /path/to/output
  output_data_type avro

  file /path/to/schema.avsc

  ## You can use schema_json instead of schema_file
  # schema {"type":"record","name":"example","namespace":"org.example","fields":[{"name":"message","type":"string"}]}
</match>
```

## License

Apache License, Version 2.0.
