  do ->

    { value-must-have-type: must-be } = dependency 'value.validation.Type'
    { create-error } = dependency 'value.Error'
    { value-as-string } = dependency 'value.serialization.Value'
    { classname-of, value-must-have-classname } = dependency 'value.validation.ClassName'

    arg-namespace = 'value.validation.Argument'

    contextualized = -> it <<< { namespace: arg-namespace }

    argument-members = (argument-object) ->

      try argument-object `must-be` 'Object'
      catch error => throw contextualized error

      [ { argument-name, argument-value } for argument-name, argument-value of argument-object ]

    argument-name-and-value = (argument-object) ->

      members = argument-members argument-object

      throw create-error "Argument object (#{ value-as-string argument-object }) must have exactly 1 member", arg-namespace \
        unless members.length is 1

      members.0

    argument-with-value = (argument-object) ->

      { argument-name, argument-value } = argument-name-and-value argument-object

      "Argument '#argument-name' with value <#{ classname-of argument-value }> #{ value-as-string argument-value }"

    compose-argument-requirement-message = (argument-object, requirement-message) ->

      requirement-message `must-be` 'String'

      [ (argument-with-value argument-object), 'must', requirement-message ] * ' '

    argument-must-have-classname = (argument-object, classname) ->

      { argument-name, argument-value } = argument-name-and-value argument-object

      try argument-value `value-must-have-classname` classname
      catch cause

        throw create-error do

          compose-argument-requirement-message argument-object, "have classname '#classname'"
          arg-namespace
          cause

    {
      argument-name-and-value, argument-with-value,
      compose-argument-requirement-message,
      argument-must-have-classname
    }
