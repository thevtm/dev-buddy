$(".chat-room__form").submit(function (event) {
  event.preventDefault();
  this.submit();
  $(".chat-room__message-input").val("");
});
