
  do ->

    { codeunit-as-string } = dependency 'value.string.CodeUnit'

    basic-names = <[ exclamation quotation hash dollar percent ampersand apostrophe lparen rparen asterisk plus comma hyphen period slash ]>
    extended-names = <[ colon semicolon lt equals gt question at ]>
    bracket-names = <[ lbracket backslash rbracket caret underscore backtick ]>
    misc-names = <[ lbrace pipe rbrace tilde ]>

    basic-punctuation = { [ name, char-code + 33 ] for name, char-code in basic-names }

    extended-punctuation = { [ name, char-code + 58 ] for name, char-code in extended-names }

    bracket-punctuation = { [ name, char-code + 91 ] for name, char-code in bracket-names }

    misc-punctuation = { [ name, char-code + 123 ] for name, char-code in misc-names }

    punctuation-codes = {} <<< basic-punctuation <<< extended-punctuation <<< bracket-punctuation <<< misc-punctuation

    punctuation-chars = { [ (name), (codeunit-as-string codeunit) ] for name, codeunit of punctuation-codes }

    { punctuation-chars }