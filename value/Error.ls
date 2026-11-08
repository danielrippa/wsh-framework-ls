
  do ->

    { get-value-type } = dependency 'value.reflection.Type'
    { value-as-string } = dependency 'value.serialization.Value'

    error-namespace = 'value.Error'

    must-be = (value, expected-type) ->

      value-type = get-value-type value

      unless value-type is expected-type

        throw create-error do
          "Value (#{ value-as-string value }) with type '#value-type' must be a '#expected-type'"
          error-namespace

    create-error = (message, namespace, cause) ->

      message `must-be` 'String'
      if namespace isnt void => namespace `must-be` 'String'
      if cause isnt void => cause `must-be` 'Object'

      new Error message

        .. <<< { namespace } if namespace isnt void
        .. <<< { cause }     if cause isnt void

        .. <<< { to-string: -> value-as-string @ }

    { create-error }

