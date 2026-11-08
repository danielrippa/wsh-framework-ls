
  do ->

    { is-function } = dependency 'value.reflection.Type'

    decompose-function = (fn) ->

      return unless is-function fn

      function-as-string = fn.to-string!

        body-start = ..index-of lbrace
        body-end   = ..last-index-of rbrace

        body-as-string = ..slice body-start + 1, body-end

        signature-as-string = ..slice 0, body-start

          kw-index = ..index-of kw
          paren-index = ..index-of lparen

          function-name = ..slice (kw-index + kw-length), paren-index

          parameters-start = ..index-of lparen
          parameters-end   = ..last-index-of rparen

          parameters-as-string = ..slice parameters-start + 1, parameters-end

          parameter-names = parameters-as-string / ','

        { function-as-string, body-as-string, signature-as-string, function-name, parameters-as-string, parameter-names }

    #

    get-function-name = -> decompose-function it => return if .. is void then void else ..function-name

    get-function-parameter-names = -> decompose-function it => return if .. is void then void else ..parameter-names

    { decompose-function, get-function-name, get-function-parameter-names }