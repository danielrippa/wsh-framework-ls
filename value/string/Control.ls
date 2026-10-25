
  do ->

    { codeunit-as-string } = dependency 'value.string.CodeUnit'

    c0-control-codes = { [ name, char-code ] for name, char-code in <[ nul soh stx etx eot enq ack bel bs ht lf vt ff cr so si dle dc1 dc2 dc3 dc4 nak syn etb can em sub esc fs gs rs us ]> }

    c1-control-codes = { [ name, char-code + 127 ] for name, char-code in <[ del pad hop bph nbh ind nel ssa esa hts htj vts pld plu ri ss2 ss3 dcs pu1 pu2 sts cch mw spa epa sos sgc sci csi st osc pm apc ]> }

    control-codes = {} <<< c0-control-codes <<< c1-control-codes

    control-chars = { [ (name), (codeunit-as-string codeunit) ] for name, codeunit of control-codes }

    { control-chars }