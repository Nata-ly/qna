$(document).on('turbolinks:load', function(){
  $('.edit-question-link').on('click', function(e) {
    e.preventDefault()
    $(this).hide()
    $('form#edit-question').removeClass('hidden')
  })

  $('.add-comment').on('click', function(e) {
    e.preventDefault()
    $(this).hide()
    $(this).parent().parent().find('.comment-form').removeClass('hidden')
  })
})
