
  do ->

    { crete-type-error } = dependency 'value.reflection.Type'
    { is-array, value-must-have-classtag } = dependency 'value.reflection.ClassTag'

    namespace = 'value.reflection.Array'

    ArrayValue = (value) ->

      try value `value-must-have-classtag` 'Array'
      catch cause => create-type-error namespace, cause.message

      value

    {
      is-array, ArrayValue
    }