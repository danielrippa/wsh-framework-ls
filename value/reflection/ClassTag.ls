
  do ->

    { is-null, is-void, create-type-error } = dependency 'value.reflection.Type'
    { StringValue } = dependency 'value.reflection.String'

    namespace = 'value.reflection.ClassTag'

    get-value-classtag = (value) ->

      switch {} |> (.to-string) |> (.call value) |> (.slice 8, -1)

        | 'Object' =>

          match value

            | is-null => 'Null'
            | is-void => 'Void'

            else that

    value-has-classtag = (value, classtag) ->

      try StringValue classtag
      catch cause => throw create-type-error namespace, cause.message

      (get-value-classtag value) is classtag

    value-must-have-classtag = (value, classtag) ->

      value-classtag = get-value-classtag value

      throw create-type-error namespace, "Value #value with classtag '#value-classtag' must have classtag '#classtag'" \
        unless value-classtag is classtag

      value

    is-a = (value, classtag) -> value `value-has-classtag` classtag

    is-array = _ `is-a` 'Array'
    is-error = _ `is-a` 'Error'
    is-date  = _ `is-a` 'Date'
    is-regexp = _ `is-a` 'RegExp'

    {
      get-value-classtag, value-has-classtag, value-must-have-classtag,
      is-array, is-error, is-date, is-regexp
    }