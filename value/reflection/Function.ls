
  do ->

    { trim } = dependency 'value.string.Whitespace'
    { create-type-error, value-must-have-type } = dependency 'value.reflection.Type'
    { punctuation-chars } = dependency 'value.string.Punctuation'

    namespace = 'value.reflection.Function'

    FunctionValue = ->

      try it `value-must-have-type` 'Function'
      catch cause => throw create-type-error namespce, cause.message

      it

    { lbrace, rbrace, lparen, rparen } = punctuation-chars

    kw = 'function' => kw-length = ..length

    decompose-function = (fn) ->

      function-as-string = (FunctionValue fn).to-string!

        body-start = ..index-of left-brace
        body-end   = ..last-index-of rbrace

        body-as-string = ..slice body-start + 1, body-end

        signature-as-string = ..slice 0, body-start

          kw-index = ..index-of kw
          paren-index = ..index-of lparen

          function-name = trim ..slice (kw-index + kw-length), paren-index

          parameters-start = ..index-of lparen
          parameters-end   = ..last-index-of rparen

          parameters-as-string = ..slice parameters-start + 1, parameters-end

          parameter-names = if parameters-as-string is '' then [] else [ (trim name) name in parameters-as-string / ',' ]

      {
        function-as-string, body-as-string, signature-as-string, parameters-as-string,
        function-name, parameter-names
      }

    function-as-string = -> decompose-function it .function-as-string

    function-body = -> decompose-function it .body-as-string
    function-signature = -> decompose-function it .signature-as-string
    function-parameters = -> decompose-function it .parameters-as-string
    function-name = -> decompose-function it .function-name

    function-parameter-names = -> decompose-function it .parameter-names

    {
      FunctionValue,
      decompose-function,
      function-as-string,
      function-body, function-signature, function-parameters,
      function-name, function-parameter-names
    }