
  do ->

    { argument-name-and-value, argument-must-have-classname, compose-argument-requirement-message, argument-with-value } = dependency 'value.validation.Argument'
    { type-of, value-must-have-type } = dependency 'value.validation.Type'
    { value-must-have-classtag } = dependency 'value.validation.ClassTag'
    { value-must-have-classname } = dependency 'value.validation.ClassName'
    { create-error } = dependency 'value.Error'
    { type-validation-enabled } = dependency 'value.validation.Enabled'

    context-namespace = 'value.validation.Context'

    argument-must = (argument, requirement) -> compose-argument-requirement-message

    contextualized = (error, namespace) -> error <<< { namespace }

    argument-value = (argument) -> argument-name-and-value argument .argument-value

    invalid = -> [ 'Invalid', argument-with-value it ] * ' '

    create-error-context = (namespace) ->

      if type-validation-enabled

        try {namespace} `argument-must-have-classname` 'String'
        catch cause => throw create-error (invalid {namespace}), context-namespace, cause

      context = do ->

        validate-argument = (argument, type, value-must-be) ->

          { argument-value } = argument-name-and-value argument ; return argument-value unless type-validation-enabled

          try argument-value `value-must-be` type
          catch cause => throw context.create-error (invalid argument), cause

          argument-value

        #

        create-error: (message, cause) -> create-error message, namespace, cause

        arg-with-type: (argument, type) -> validate-argument argument, type, value-must-have-type
        arg-with-classtag: (argument, classtag) -> validate-argument argument, classtag, value-must-have-classtag
        arg-with-clasname: (argument, classname) -> validate-argument argument, classname, value-must-have-classname

    { create-error-context }






