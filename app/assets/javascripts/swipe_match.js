
var myElement = document.querySelector('.match-profile');
var myOptions = {}
var matchButton = document.getElementById('match-button');
var notMatchButton = document.getElementById('not-match-button');

var hammertime = new Hammer(myElement, myOptions);


var swipeRight = hammertime.on('swiperight',
  function(ev) {
     ev.preventDefault();
     myElement.classList.add('animated', 'rotateOutUpRight')
      $('.match-profile').on('animationend', () => Rails.fire(matchButton, "click"));
});

var swipeLeft = hammertime.on('swipeleft',
  function(ev) {
     ev.preventDefault();
     myElement.classList.add('animated', 'rotateOutUpLeft')
      $('.match-profile').on('animationend', () => location.reload());
});








// var afterSwipeLeft = function(ev) {
//      Rails.fire(notMatchButton, "click");
// };



