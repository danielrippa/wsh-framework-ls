
  do ->

    { is-object } = dependency 'value.reflection.Type'
    { get-function-name } = dependency 'value.reflection.Function'

    get-object-constructor-name = (object) ->

      return unless is-object object ; { constructor } = object
      if constructor is void then void else get-function-name constructor

    #

    { get-object-constructor-name }


