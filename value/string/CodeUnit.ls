
  do ->

    { create-type-error } = dependency 'value.reflection.Type'
    { NumberArray } = dependency 'value.reflection.Number'

    namespace = 'value.string.CodeUnit'

    high-surrogate = start: 0xd800, end: 0xdbff
    low-surrogate = start: 0xdc00, end: 0xdfff

    completes-pair = (codeunit) -> codeunit >= low-surrogate.start and codeunit <= low-surrogate.end

    needs-pair = (codeunit) -> codeunit >= high-surrogate.start and codeunit <= high-surrogate.end

    codeunits-as-codeunit-sequence = (codeunits) ->

      try NumberArray codeunits
      catch cause => throw create-type-error namespace, cause.message

      sequence = [] ; consumed = no

      for codeunit, index in codeunits

        if consumed => consumed = no ; continue

        has-next = index + 1 < codeunits.length
        next-completes = has-next and completes-pair codeunits[ index + 1 ]

        is-surrogate-pair = needs-pair codeunit and next-completes

        if is-surrogate-pair
          sequence.push [codeunit, codeunits[i + 1]]
          consumed = yes
        else
          sequence.push [codeunit]

      sequence

    codeunit-element-as-char = (element) -> String.from-char-code.apply null, element

    codeunit-sequence-as-logical-character-array = (sequence) -> [ codeunit-element-as-char element for element in sequence ]

    codeunit-sequence-as-string = (sequence) -> sequence |> codeunit-sequence-as-logical-character-array |> (* '')

    codeunits-as-string = (codeunits) -> codeunits-as-codeunit-sequence codeunits |> codeunits-sequence-as-string

    codeunit-as-string = (codeunit) -> codeunits-as-string [ codeunit ]

    { codeunit-as-string }