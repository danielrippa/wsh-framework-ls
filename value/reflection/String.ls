
  do ->

    { is-string, value-must-have-type, create-type-error } = 'value.reflection.Type'
    { ArrayValue } = dependency 'value.reflection.Array'

    namespace = 'value.reflection.String'

    StringValue = -> it `value-must-have-type` 'string' ; it

    StringArray = (array) ->

      try ArrayValue array
      catch cause => throw create-type-error namespace, cause.message

      for item in array

        try StringValue item
        catch cause => throw create-type-error namespace, cause.message

      array

    { is-string, StringValue, StringArray }

