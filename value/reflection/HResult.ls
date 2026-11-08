
  do ->

    { is-number } = dependency 'value.reflection.Type'

    decompose-hresult = (value) ->

      return unless is-number value

      value .>>>. 0

        severity = (.. .>>>. 31) .&. 1
        facility = (.. .>>. 16) .&. 0x7ff
        code = .. .&. 0xffff

      { severity, facility, code }

    { decompose-hresult }