
  do ->

    { get-value-classtag } = dependency 'value.reflection.ClassTag'

    is-array = -> (get-value-classtag it) is 'Array'

    get-array-size = -> return unless is-array it ; it.length

    { is-array, get-array-size }