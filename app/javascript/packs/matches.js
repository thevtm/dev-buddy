if ($(".match-mount").length > 0) {

  const CSRF_TOKEN = $(`meta[name="csrf-token"]`).attr("content");

  const MATCH_MOUNT_POINT_TOP_CLASS = "match-mount__point--top";
  const MATCH_MOUNT_POINT_BOTTOM_CLASS = "match-mount__point--bottom";

  const match_point_wrapper = $(".match-mount__wrapper");

  const get_match_point_top = () => $(`.${MATCH_MOUNT_POINT_TOP_CLASS}`);
  const get_match_point_bottom = () => $(`.${MATCH_MOUNT_POINT_BOTTOM_CLASS}`);
  const get_match_point_top_user_data = () => $(`.${MATCH_MOUNT_POINT_TOP_CLASS} .match-profile__data`).data();
  const get_match_point_top_user_id = () => get_match_point_top_user_data().userId;

  const remove_match_point_top = () => get_match_point_top().remove();
  const promote_match_point_bottom = () => get_match_point_bottom()
    .removeClass(MATCH_MOUNT_POINT_BOTTOM_CLASS).addClass(MATCH_MOUNT_POINT_TOP_CLASS);

  const append_new_match_point_bottom = (html) => {
    match_point_wrapper
      .append(`
        <div class="match-mount__point match-mount__point--bottom">
          ${html}
        </div>
      `);
  }

  const match_action = (other_user_id, match) => {
    match = match ? "1" : "0";
    const url = `${window.location.pathname}?${$.param({ other_user_id, match })}`;

    return fetch(url, {
        method: "POST",
        credentials: "same-origin",
        headers: {
          "X-CSRF-Token": CSRF_TOKEN
        }
      })
      .then((res) => res.json())
      .then((data) => {
        console.log(data);
        remove_match_point_top();
        promote_match_point_bottom();
        append_new_match_point_bottom(data.new_match_html);
        attach_swiper_to_match_point_top();
      })
      .catch((err) => console.error(err));
  }

  const match_pass_action = () => {
    const user_id = get_match_point_top_user_id();
    match_action(user_id, false);
  }

  const match_meet_action = () => {
    const user_id = get_match_point_top_user_id();
    match_action(user_id, true);
  }

  const attach_swiper_to_match_point_top = () => {
    const el = document.querySelector(".match-mount__point--top");
    const opts = {}

    const hammertime = new Hammer(el, opts);

    hammertime.on("swiperight",
      function (ev) {
        ev.preventDefault();
        el.classList.add("animated", "rotateOutUpRight")
        get_match_point_top().on("animationend", () => match_meet_action());
      });

    hammertime.on("swipeleft",
      function (ev) {
        ev.preventDefault();
        el.classList.add("animated", "rotateOutUpLeft")
        get_match_point_top().on("animationend", () => match_pass_action());
      });
  }

  // OnReady
  attach_swiper_to_match_point_top();

  $(".match-footer__btn-pass").click(function (event) {
    event.preventDefault();
    const el = get_match_point_top();

    el.addClass("animated rotateOutUpLeft");
    el.on("animationend", () => match_meet_action());
  })

  $(".match-footer__btn-meet").click(function (event) {
    event.preventDefault();
    const el = get_match_point_top();

    el.addClass("animated rotateOutUpRight");
    el.on("animationend", () => match_pass_action());
  })
}
