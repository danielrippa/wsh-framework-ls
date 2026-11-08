
  do ->

    { get-value-classtag } = dependency 'value.reflection.ClassTag'

    is-error = -> (get-value-classtag it) is 'Error'

    { is-error }