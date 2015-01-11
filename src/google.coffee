console.log 'Yo FOOOOOD'
console.log $('#main')

$('#main')[0].addEventListener(
  'DOMNodeInserted'
  (event)->
    return unless event.relatedNode.id is 'search'
    results = $(event.relatedNode).find('.g')
    return unless results.length
    console.debug results

    results.each -> loadGoogleResult @
)

loadGoogleResult = (element)->
  console.log recipeUrl = $(element).find('.r > a[href]').first().attr('href')

  $.get(recipeUrl, 'text').then (results)->
    myParsedElement = $(results)
    console.log myParsedElement

    allIngredients = []
    myParsedElement.find('[itemprop="ingredients"]').each -> allIngredients.push $(@).text()
    matchedIngredients = []
    _.each allIngredients, (ingredient)->
      match = ingredient.match ingredientsRegex
      matchedIngredients.push match[1] if match
    matchedIngredients = _.uniq matchedIngredients
    console.log recipeUrl, matchedIngredients
    if matchedIngredients.length is 0
      $(element).find('h3').addClass('done')
      return
    getRating(matchedIngredients)
    .done ->
      $(element).find('h3').addClass('done')
    .then (result)->
      return unless result.ratings.yummy + result.ratings.health >0
      console.log result
      $(element).find('h3').append "
      <span class='HACKATHON-search-wrapper'>
        <span class='HACKATHON-google yummie'>Yummie #{result.ratings.yummy}</span>
        <span class='HACKATHON-google healthy'>Healthy #{result.ratings.health}</span>
      </span>"