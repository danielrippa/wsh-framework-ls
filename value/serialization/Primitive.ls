
  do ->

    { is-primitive, is-string } = dependency 'value.reflection.Type'

    primitive-as-string = -> return unless is-primitive it ; if is-string it then "'#it'" else "#it"

    { primitive-as-string }