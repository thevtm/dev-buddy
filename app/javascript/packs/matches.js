if ($(".match-mount").length > 0) {

  const CSRF_TOKEN = $(`meta[name="csrf-token"]`).attr("content");

  const ITS_A_MATCH_CLASS = "its-a-match";
  const MATCH_MOUNT_POINT_TOP_CLASS = "match-mount__point--top";
  const MATCH_MOUNT_POINT_BOTTOM_CLASS = "match-mount__point--bottom";
  const MATCH_PROFILE_CLASS = "match-profile";
  const MATCH_FOOTER_CLASS = "match-footer";

  const match_point_wrapper = $(".match-mount__wrapper");

  const get_match_point_top = () => $(`.${MATCH_MOUNT_POINT_TOP_CLASS}`);
  const get_match_profile_top = () => $(`.${MATCH_MOUNT_POINT_TOP_CLASS} .${MATCH_PROFILE_CLASS}`);
  const get_match_point_bottom = () => $(`.${MATCH_MOUNT_POINT_BOTTOM_CLASS}`);
  const get_match_point_top_its_a_match = () => $(`.${MATCH_MOUNT_POINT_TOP_CLASS} .${ITS_A_MATCH_CLASS}`);
  const get_match_point_top_user_data = () => $(`.${MATCH_MOUNT_POINT_TOP_CLASS} .match-profile__data`).data();
  const get_match_point_top_user_id = () => get_match_point_top_user_data().userId;

  const show_its_a_match = () => get_match_point_top_its_a_match().css("display", "block");

  const hide_all_match_profile = () => $(`.${MATCH_PROFILE_CLASS}`).hide();
  const show_all_match_profile = () => $(`.${MATCH_PROFILE_CLASS}`).show();

  const hide_match_footer = () => $(`.${MATCH_FOOTER_CLASS}`).hide();
  const show_match_footer = () => $(`.${MATCH_FOOTER_CLASS}`).show();

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

  const match_action = _.debounce((other_user_id, match) => {
    match = match ? "1" : "0";
    const url = `${window.location.pathname}?${$.param({ other_user_id, match })}`;
    const el_top = get_match_point_top();
    const el_bottom = get_match_point_bottom();

    return fetch(url, {
        method: "POST",
        credentials: "same-origin",
        headers: {
          "X-CSRF-Token": CSRF_TOKEN
        }
      })
      .then((res) => res.json())
      .then((data) => {
        if (true) {
          hide_all_match_profile();
          hide_match_footer();
          show_its_a_match();
        } else {
          remove_match_point_top();
          promote_match_point_bottom();
          append_new_match_point_bottom(data.new_match_html);
          attach_swiper_to_match_point_top();
        }
      })
      .catch((err) => console.error(err));
  }, 1000);

  const match_action_pass = () => {
    const user_id = get_match_point_top_user_id();
    const el = get_match_profile_top();

    el.addClass("animated rotateOutUpLeft");
    el.on("animationend", () => match_action(user_id, false));
  }

  const match_action_meet = () => {
    const user_id = get_match_point_top_user_id();
    const el = get_match_profile_top();

    el.addClass("animated rotateOutUpRight");
    el.on("animationend", () => match_action(user_id, true));
  }

  const attach_swiper_to_match_point_top = () => {
    const el = document.querySelector(".match-mount__point--top");
    const opts = {}

    const hammertime = new Hammer(el, opts);

    hammertime.on("swiperight",
      function (ev) {
        ev.preventDefault();
        match_action_meet();
      });

    hammertime.on("swipeleft",
      function (ev) {
        ev.preventDefault();
        match_action_pass()
      });
  }

  // OnReady
  attach_swiper_to_match_point_top();

  $(".match-footer__btn-pass").click(function (event) {
    event.preventDefault();
    match_action_pass();
  })

  $(".match-footer__btn-meet").click(function (event) {
    event.preventDefault();
    match_action_meet();
  })
}
