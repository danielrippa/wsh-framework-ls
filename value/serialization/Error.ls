
  do ->

    { is-error } = dependency 'value.reflection.Error'
    { hresult-as-string } = dependency 'value.serialization.HResult'

    error-as-string = (error) ->

      return unless is-error error

      { namespace, message, number, cause } = error

      error-message = if number isnt void

        then "#message with #{ hresult-as-string number }"
        else message

      error-string = if namespace is void

        then error-message
        else "(#namespace) #error-message"

      if cause isnt void

        cause-string = if (typeof cause.to-string) is 'function' and cause.to-string isnt Error.prototype.to-string

          then cause.to-string!
          else error-as-string cause

        [ error-string, '\n ', 'Cause:', cause-string ] * ' '

      else

        error-string

    { error-as-string }

