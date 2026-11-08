
  do ->

    { get-value-classtag } = dependency 'value.reflection.ClassTag'
    { value-must-have-type: must-be } = dependency 'value.validation.Type'
    { create-error } = dependency 'value.Error'

    classtag-namespace = 'value.validation.ClassTag'

    classtag-of = -> get-value-classtag it

    has-classtag = (value, classtag) -> (classtag-of value) is (classtag `must-be` 'String')

    create-classtag-error = (value, classtag, namespace, cause) ->

      unless type-validation-enabled

        classtag `must-be` 'String'

      create-error do

        "Value (#{ value-as-string value }) with classtag '#{ classtag-of value }' must have classtag '#classtag'"
        namespace
        cause

    value-must-have-classtag = (value, classtag) ->

      unless value `has-classtag` classtag
        throw create-classtag-error value, classtag, classtag-namespace
      value

    { classtag-of, has-classtag, value-must-have-classtag, create-classtag-error }
