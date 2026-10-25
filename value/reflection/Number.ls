
  do ->

    { is-finite-number: is-number, create-type-error } = dependency 'value.reflection.Type'
    { ArrayValue } = dependency 'value.reflection.Array'

    namespace = 'value.reflection.Number'

    NumberValue = (value) ->

      try value `value-must-have-type` 'number'
      catch cause => throw create-type-error namespace, cause.message

      value

    NumberArray = (array) ->

      try ArrayValue array
      catch cause => throw create-type-error namespace, cause.message

      for item in array => NumberValue item

      array

    {
      is-number, NumberValue, NumberArray
    }