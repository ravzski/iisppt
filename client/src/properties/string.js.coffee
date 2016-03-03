String::formatDate = ->
  if !!this.toString() then moment(new Date(this.toString())).format(DATE_FORMAT) else moment()

String::formatTimestamp = ->
  if !!this.toString() then moment(new Date(this.toString())).format(TIMESTAMP_FORMAT) else  moment()

# because there is no trim() in IE8 SUCKSSSS
String::trim = ->
  @replace /^\s+|\s+$/g, ''

String::toFloat = ->
  parseFloat(this)

String::formatMoney = ->
  parseFloat(this).formatMoney()

String::removeUnderscore = ->
  this.replace(/_/g, ' ')

String::capitalize = ->
  @replace /(?:^|\s)\S/g, (a) ->
    a.toUpperCase()

String::validateEmail =  ->
  re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  re.test this.toString()
