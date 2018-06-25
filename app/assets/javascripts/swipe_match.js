
var myElement = document.getElementById('swiper');
var myOptions = {}
var matchButton = document.getElementById('match-button');


var hammertime = new Hammer(myElement, myOptions);

hammertime.on('swiperight',
  function(ev) {
     ev.preventDefault();
     myElement.classList.add('animated', 'rotateOutUpRight');
     matchButton.submit()

  ;
});
