
  do ->

    { is-number } = dependency 'value.reflection.Type'
    { is-array } = dependency 'value.reflection.Array'

    #

    high-surrogate = start: 0xd800, end: 0xdbff
    low-surrogate = start: 0xdc00, end: 0xdfff

    completes-pair = (codeunit) -> codeunit >= low-surrogate.start and codeunit <= low-surrogate.end

    needs-pair = (codeunit) -> codeunit >= high-surrogate.start and codeunit <= high-surrogate.end

    #

    is-codeunit = (codeunit) ->

      (is-number codeunit) and
        codeunit >= 0 and
        codeunit <= 0xffff and
        codeunit % 1 is 0

    are-codeunits = (codeunits) ->

      return no unless is-array codeunits
      for codeunit in codeunits => return no unless is-codeunit codeunit

      yes

    #

    codeunits-as-codeunit-sequence = (codeunits) ->

      return unless are-codeunits codeunits

      sequence = [] ; consumed = no

      for codeunit, index in codeunits

        if consumed => consumed = no ; continue

        has-next = index + 1 < codeunits.length
        next-completes = has-next and completes-pair codeunits[index + 1]
        is-surrogate-pair = needs-pair(codeunit) and next-completes

        sequence.push = if is-surrogate-pair
          consumed = yes
          [ codeunit, codeunits[index + 1] ]
        else
          [ codeunit ]

      sequence

    #

    char = -> String.from-char-code it

    codeunit-sequence-as-logical-character-array = (sequence) -> [ (char element) for element in sequence ]

    codeunit-sequence-as-string = (sequence) ->

      return unless is-array sequence

      chars = codeunit-sequence-as-logical-character-array sequence
      return unless is-array chars

      chars * ''

    #

    codeunits-as-string = (codeunits) ->

      return unless are-codeunits codeunits

      sequence = codeunits-as-codeunit-sequence codeunits
      return unless is-array sequence

      sequence |> codeunit-sequence-as-string

    codeunit-as-string = -> return unless is-codeunit it ; codeunits-as-string [ it ]

    codeunits-as-logical-character-array = (codeunits) ->

      return unless are-codeunits codeunits

      codeunits
        |> codeunits-as-codeunit-sequence
        |> codeunit-sequence-as-logical-character-array

    #

    {
      is-codeunit, are-codeunits,
      codeunit-as-string, codeunits-as-string,
      codeunits-as-logical-character-array
    }