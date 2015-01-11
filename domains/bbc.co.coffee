console.log 'bbc.co.uk'
allIngredients = []
$('#ingredients .ingredient').each -> allIngredients.push $(@).text()
console.log allIngredients
matchedIngredients = []
_.each allIngredients, (ingredient)->
  match = ingredient.match ingredientsRegex
  matchedIngredients.push match[1] if match
matchedIngredients = _.uniq matchedIngredients

console.log matchedIngredients

getRatingHtml(matchedIngredients).then (html)->
  $('#food-image').wrap('<div style="position:relative">').css(position:'relative').after html