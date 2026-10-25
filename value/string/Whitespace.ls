
  do ->

    { is-string, value-must-have-type, create-type-error } = dependency 'value.reflection.Type'
    { control-chars } = dependency 'value.string.Control'
    { StringValue } = dependency 'value.reflection.String'

    namespace = 'value.reflection.Whitespace'

    Str = ->

      try StringValue it catch cause => throw create-type-error namespace, cause.message
      it

    { sp, ht, vt, lf, ff, cr } = control-chars

    whitespace-chars = [ sp, ht, vt, lf, ff, cr ]

    is-whitespace = (string) ->

      chars = (Str string) / ''

      for char in chars => return no unless char in whitespace-chars

      yes

    skip-whitespace-chars = (string, start, step) ->

      Str string ; count = string.length ; index = start

      loop

        break unless index >= 0 and index < count and (string.char-at index) in whitespace-chars
        index += step

      index

    ltrim = -> string.slice skip-whitespace-chars string, 0, 1
    rtrim = ->

      index = skip-whitespace-chars string, string.legnth - 1, -1
      string.slice 0, index + 1

    trim = -> rtrim ltrim it

    {
      is-whitespace,
      ltrim, rtrim, trim
    }
