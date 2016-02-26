Array::isEmpty = () ->
  if this.length == 0 then true else false

Array::include = (element) ->
  if this.indexOf(element) >= 0 then true else false

Array::unique = () ->
  unique = []
  for element in this
    unique.push(element) if !unique.include(element)
  return unique

Array::mapBy = (attribute) ->
  map = []
  for element in this
    map.push(element[attribute])
  return map

Array::select = (attribute, value) ->
  selected = []
  for element in this
    selected.push(element) if value == element[attribute]
  return selected
