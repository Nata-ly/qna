$(document).on('turbolinks:load', function(){

  $('.link-update').on('submit', updateAllGist)

  function updateAllGist(){
    setTimeout(function(){
    const gists = $(".link-gist:not(:has(>div))")
    gists.each(function(){
      loadGist(this)
    })
  }, 500)
  }

  function loadGist(linkGist){
    let gistId = linkGist.dataset.gistId
    var printGist = function(gist) { $(linkGist).prepend(gist.div); };
    $.ajax({ url: 'https://gist.github.com/' + gistId + '.json', dataType: 'jsonp', success: printGist })
  }
})
