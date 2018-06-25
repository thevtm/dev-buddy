function carousel() {

  M.AutoInit();

  document.addEventListener('DOMContentLoaded', function () {
    var elems = document.querySelectorAll('.carousel');
    var instances = M.Carousel.init(elems, options);
  });

  var instance = M.Carousel.init({
    fullWidth: true,
    indicators: true
  });

  var instance = M.Carousel.getInstance(elem);
  instance.next();
  instance.prev();

}

export {
  carousel
};
