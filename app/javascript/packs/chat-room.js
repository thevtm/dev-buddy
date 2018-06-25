const chat_room_data = $(".chat-room__data").data();
const chat_room_box = $(".chat-room__box");
const chat_room_message_input = $(".chat-room__message-input");

let chat_room_last_message_datetime = chat_room_data.otheruserlastmessagedatetime;

const chat_box_scroll_bottom = () => chat_room_box.scrollTop(1000);

function fetch_other_user_new_messages(last_message_datetime) {
  const url = `${window.location.pathname}/other_messages?${$.param({ last_message_datetime })}`;
  return fetch(url, {
    credentials: 'include'
  })
}

function append_my_message(message) {
  chat_room_box
    .append(`
      <div class="chat-room__message-box chat-room__message-box--me">
        <span class="chat-room__message chat-room__message--me">
          ${message}
        </span>
      </div>
    `);
}

function append_other_message(message) {
  chat_room_box
    .append(`
      <div class="chat-room__message-box chat-room__message-box--not-me">
        <span class="chat-room__message chat-room__message--not-me">
          ${message}
        </span>
      </div>
    `);
}

function handle_other_users_messages() {
  fetch_other_user_new_messages(chat_room_last_message_datetime)
    .then(res => res.json())
    .then(data => {
      console.log(data);
      chat_room_last_message_datetime = data.last_message_datetime
      for (const message of data.new_messages) {
        append_other_message(message.message);
      }
    })
    .catch(err => console.error(err))
}

$(".chat-room__form").submit(function (event) {
  event.preventDefault();

  const message = chat_room_message_input.val();

  if (message === "") {
    return;
  }

  append_my_message(message);
  chat_box_scroll_bottom();

  this.submit();

  chat_room_message_input.val("");
});

// OnReady
chat_box_scroll_bottom();
setInterval(() => handle_other_users_messages(), 2500);
