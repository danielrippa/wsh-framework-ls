
  do ->

    { is-number } = dependency 'value.reflection.Type'
    { decompose-hresult } = dependency 'value.reflection.HResult'

    hint = (message, constant) -> { message, "(#constant)" } * ' '

    as-hint = (facility, code) ->

      match facility, code

        | (==  4), (== 0x0154) => hint 'ProgId not registered', 'regdb-e-classnotreg'
        | (==  4), (== 0x4005) => hint 'General COM failure', 'e-fail'
        | (==  7), (== 0x0005) => hint 'Elevation required', 'e-accessdenied'
        | (==  7), (== 0x007e) => hint 'DLL missing from registered path', 'error-mod-not-found'
        | (== 19), (== 0x1522) => hint 'Class not found in DLL', 'cor-e-typeload'
        | (== 19), (== 0x1040) => hint 'Registered DLL path does not exist', 'cor-e-filenotfound'

        | (== 19), (== 0x0000) => 'CLR failure - .NET runtime could not initialise the type'

        else ''

    members-as-string = -> [ "#name: #value" for name, value of it ] * ', '

    hresult-as-string = (value) ->

      return unless is-number value

      { severity, facility, code } = decompose-hresult value

      "HRESULT (#{ members-as-string { severity, facility, code } }) #{ as-hint facility, code }"

    { hresult-as-string }