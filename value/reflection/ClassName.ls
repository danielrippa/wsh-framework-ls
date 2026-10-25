
  do ->

    { get-value-classtag } = dependency 'value.reflection.ClassTag'
    { create-type-error } = dependency 'value.reflection.Type'
    { StringValue } = dependency 'value.reflection.String'

    namespace = 'value.reflection.ClassName'

    constructor-name-or-classtag = (value, classtag) ->

      constructor-name = get-object-constructor-name value

        return if .. is '' then classtag else ..

    get-value-classname = (value) ->

      value-classtag = get-value-classtag value

      switch

        | 'Object' => constructor-name-or-classtag value, value-classtag
        | 'Error'  => value.name

        else that


    Str = ->

      try StringValue classname
      catch cause => throw create-type-error namespace, cause.message

      it

    value-has-classname = (value, classname) -> (get-value-classname value) is (Str classname)

    value-must-have-classname = (value, classname) ->

      value-classname = get-value-classname value

      throw create-type-error namespace, "Value #value with classname #value-classname must have classname '#classname'" \
        unless value-classname is (Str classname)

      value

    {
      get-value-classname, value-has-classname, value-must-have-classname
    }