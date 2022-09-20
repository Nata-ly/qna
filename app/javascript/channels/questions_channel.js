import consumer from "./consumer"

$(document).on('turbolinks:load', function() {

  if (document.querySelector('#questions-list')){
    var subscription = consumer.subscriptions.create("QuestionsChannel", {
      connected() {
      },

      disconnected() {
      },

      received(data) {
        $('#questions-list').append('<p><a href="/questions/' + data.id + '">' + data.title +'</a></p>')
      }
    })
    this.subscription = subscription
  }
})
