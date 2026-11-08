
  do ->

    is-null = (== null)
    is-void = (== void)

    #

    is-a = (value, type) -> (typeof value) is type

    is-string = _ `is-a` 'string'
    is-boolean = _ `is-a` 'boolean'
    is-function = _ `is-a` 'function'

    #

    primitive-type-names = <[ undefined boolean number string ]>

    is-primitive = -> (typeof it) in primitive-type-names

    #

    is-object = (value) ->

      return no unless (typeof value) is 'object'

      match value

        | is-void => no
        | is-null => no

        else yes

    #

    is-nan = (!= it)

    { POSITIVE_INFINITY: posinf, NEGATIVE_INFINITY: neginf } = Number

    is-infinity = (value) ->

      switch value

        | posinf, neginf => yes

        else no

    is-number = (value) ->

      return no unless (typeof value) is 'number'

      match value

        | is-nan => no
        | is-infinity => no

        else yes

    #

    capitalized = -> initial = it.char-at 0 .to-upper-case! ; rest = it.slice 1 .to-lower-case! ; [ initial, rest ] * ''

    get-value-type = (value) ->

      match value

        | is-null => 'Null'
        | is-void => 'Void'

        | is-nan => 'NaN'
        | is-infinity => 'Infinity'

        | is-object => 'Object'
        | is-function => 'Function'

        else capitalized typeof value

    {
      is-null, is-void,
      is-string, is-boolean, is-function,
      is-primitive, is-object,
      is-nan, is-infinity, is-number,
      get-value-type
    }