  do ->

    { get-value-classname } = dependency 'value.reflection.ClassName'
    { value-must-have-type: must-be } = dependency 'value.validation.Type'
    { value-as-string } = dependency 'value.serialization.Value'
    { type-validation-enabled } = dependency 'value.validation.Enabled'
    { create-error } = dependency 'value.Error'

    classname-namespace = 'value.validation.ClassName'

    classname-of = -> get-value-classname it

    has-classname = (value, classname) ->

      unless type-validation-enabled => classname `must-be` 'String'
      (classname-of value) is classname

    create-classname-error = (value, classname, namespace, cause) ->

      unless type-validation-enabled => classname `must-be` 'String'

      create-error "Value (#{ value-as-string value }) with classname '#{ classname-of value }' must have classname '#classname'", namespace, cause

    value-must-have-classname = (value, classname) ->

      unless type-validation-enabled => classname `must-be` 'String'

      unless value `has-classname` classname

        throw create-classname-error value, classname, classname-namespace

      value

    { classname-of, has-classname, value-must-have-classname, create-classname-error }
