
  do ->

    { get-value-classtag } = dependency 'value.reflection.ClassTag'
    { get-object-constructor-name } = dependency 'value.reflection.Object'

    constructor-name-or-classtag = (value, classtag) ->

      constructor-name = get-object-constructor-name value
      if constructor-name is void then classtag else constructor-name

    get-value-classname = (value) ->

      switch get-value-classtag value

        | 'Object' => constructor-name-or-classtag value, that
        | 'Error' => value.name

        else that

    { get-value-classname }