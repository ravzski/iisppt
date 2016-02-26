Number::formatMoney = (c, d, t) ->
  n = this
  c = 2
  d = if d == undefined then '.' else d
  t = if t == undefined then ',' else t
  s = if n < 0 then '-' else ''
  i = parseInt(n = Math.abs(+n or 0).toFixed(c)) + ''
  j = if (j = i.length) > 3 then j % 3 else 0
  s + (if j then i.substr(0, j) + t else '') + i.substr(j).replace(/(\d{3})(?=\d)/g, '$1' + t) + (if c then d + Math.abs(n - i).toFixed(c).slice(2) else '')


Number::getMonth = ->
  switch this.valueOf()
    when 1 then "Jan"
    when 2 then "Feb"
    when 3 then "Mar"
    when 4 then "Apr"
    when 5 then "May"
    when 6 then "Jun"
    when 7 then "Jul"
    when 8 then "Aug"
    when 9 then "Sep"
    when 10 then "Oct"
    when 11 then "Nov"
    when 12 then "Dec"