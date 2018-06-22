$(".match-footer__meet")
  .on("ajax:success", function (event) {
    const [data, status, xhr] = event.detail;

    $(".match-profile").css("display", "none");
    $(".match-footer__nav").css("display", "none");

    $(".its-a-match").css("display", "block");

    setTimeout(location.reload.bind(location), 2500);

    // if (data.match === true) {
    //   location.reload();
    // } else {
    //   location.reload();
    // }
  })
  .on("ajax:error", function (event) {
    console.error(event);
  });
