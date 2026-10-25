
  do ->

    create-type-error = (namespace, message) -> new Error "(#namespace) #message"

    get-value-type = (value) -> typeof value

    value-has-type = (value, expected-type) -> (get-value-type value) is (expected-type `value-must-have-type` 'string')

    value-must-have-type = (value, expected-type) ->

      value-type = get-value-type value

      throw create-type-error 'prelude.Type', "Value #value with type '#value-type' must be a '#expected-type'" \
        unless value `value-has-type` (expected-type `value-must-have-type` 'string')

      value

    is-string = _ `value-has-type` 'string'
    is-boolean = _ `value-has-type` 'boolean'
    is-function = _ `value-has-type` 'function'

    is-null = (== null)
    is-void = (== void)

    is-defined = (!= void)

    is-empty-value = ->

      match value
        | is-null => yes
        | is-void => yes
        else no

    #

    is-object = (value) ->

      return no unless value `value-has-type` 'object'
      not is-empty-value value

    is-nan = -> it isnt it

    #

    { POSITIVE_INFINITY: posinf, NEGATIVE_INFINITY: neginf } = Number

    is-infinity = (value) ->

      switch value
        | posinf, neginf => yes
        else no

    is-finite-number = (value) ->

      return no unless value `has-type` 'number'

      match value
        | is-nan => no
        | is-infinity => no
        else yes

    {
      create-type-error,
      get-value-type, value-has-type, value-must-have-type,
      is-string, is-boolean, is-function,
      is-null, is-void, is-defined, is-empty-value,
      is-object,
      is-nan, is-infinity, is-finite-number
    }