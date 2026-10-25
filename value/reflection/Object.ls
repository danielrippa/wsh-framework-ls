
  do ->

    { is-object, value-must-have-type, create-type-error } = dependency 'value.reflection.Type'
    { punctuation-chars } = dependency 'value.string.Punctuation'

    namespace = 'value.reflection.Object'

    ObjectValue = ->

      try value `value-must-have-type` 'object'
      catch cause => throw create-type-error namespace, cause.message

      it

    constructor-name-start-and-end = (constructor-as-string) ->

      [ (constructor-as-string.index-of char) for char in [ spc, lparen ] ]

    get-object-constructor-name = (object) ->

      { constructor } = ObjectValue object ; return '' if constructor is void

      constructor.to-string!

        [ start, end ] = constructor-name-start-and-end ..

        return ..slice start + 1, end

    {
      ObjectValue,
      get-object-constructor-name
    }


