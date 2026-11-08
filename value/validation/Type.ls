  do ->

    { get-value-type } = dependency 'value.reflection.Type'
    { create-error } = dependency 'value.Error'
    { value-as-string } = dependency 'value.serialization.Value'
    { type-validation-enabled } = dependency 'value.validation.Enabled'

    namespace = 'value.validation.TypeError'

    type-of = -> get-value-type it

    has-type = value-has-type = (value, expected-type) ->

      if type-validation-enabled
        unless (type-of expected-type) is 'String'
          throw create-type-error expected-type, 'String', namespace

      (type-of value) is expected-type

    create-type-error = (value, expected-type, namespace, cause) -> create-error "Value (#{ value-as-string value }) with type '#{ type-of value }' must be a '#{ expected-type }'", namespace, cause

    must-be = value-must-have-type = (value, expected-type) ->

      if type-validation-enabled
        throw create-type-error value, expected-type unless value `has-type` expected-type
      value

    { type-of, has-type, create-type-error, value-must-have-type }
