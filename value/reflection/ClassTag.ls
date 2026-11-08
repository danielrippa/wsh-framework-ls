
  do ->

    { is-null, is-void } = dependency 'value.reflection.Type'

    get-value-classtag = (value) ->

      switch {} |> (.to-string) |> (.call value) |> (.slice 8, -1)

        | 'Object' =>

          match value

            | is-null => 'Null'
            | is-void => 'Void'

            else that

        else that

    { get-value-classtag }