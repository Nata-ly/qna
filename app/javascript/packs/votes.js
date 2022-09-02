$(document).on('turbolinks:load', function(){
  $('.edit-votes-link').on('ajax:success', function(e){
    let data = e.detail[0]
    this.parentElement.querySelector('.value').innerHTML = String(data.value)
  })
    .on('ajax:error', function(e) {
      let data = e.detail[0]
      div = this.parentElement.querySelector('.votes-errors')
      div.innerHTML = String(data.message)
      setTimeout( () => $(div).empty(), 2000)
    })
})
