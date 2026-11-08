
  do ->

    { is-object, is-primitive } = dependency 'value.reflection.Type'
    { get-value-classtag } = dependency 'value.reflection.ClassTag'
    { decompose-function } = dependency 'value.reflection.Function'
    { error-as-string } = dependency 'value.serialization.Error'

    with-comma = ', ' ; with-brackets = ([prefix, suffix = prefix ]) -> -> [ prefix, it, suffix ] * ''

    curly-brackets = with-brackets <[ { } ]> ; square-brackets = with-brackets <[ [ ] ]> ; round-brackets = with-brackets <[ ( ) ]>
    single-quotes = with-brackets <[ ' ]>

    as-sequence = (brackets) -> (items) -> items.join with-comma |> with-brackets _, [ ' ' ] |> brackets
    as-array = square-brackets |> as-sequence ; as-object = curly-brackets |> as-sequence

    as-function = -> [ it, '->', curly-brackets '' ] * ''

    member-as-string = (name, value) -> [ name, ': ', value ] * ''

    #

    object-as-string = (object) -> [ (member-as-string name, value-as-string value) for name, value of object ] |> as-object
    array-as-string = (array) -> [ (value-as-string value) for value in array ] |> as-array

    function-as-string = -> decompose-function it |> (.parameters-as-string) |> round-brackets |> as-function

    #

    value-as-string = (value) ->

      switch get-value-classtag value

        | 'Void' => 'void'
        | 'Null' => 'null'

        | 'String' => single-quotes value
        | 'Function' => function-as-string value

        | 'Array'  => array-as-string value
        | 'Object' => object-as-string value

        | 'Error' => error-as-string value

        else String value

    { value-as-string }