
var myElement = document.querySelector('.match-profile');
var myOptions = {}
var matchButton = document.getElementById('match-button');


var hammertime = new Hammer(myElement, myOptions);

hammertime.on('swiperight',
  function(ev) {
     ev.preventDefault();
     myElement.classList.add('animated', 'rotateOutUpRight');
     Rails.fire(matchButton, "click")

  ;
});

// document.body.addEventListener('ajax:success', function(event) {
//   var detail = event.detail;
//   var data = detail[0], status = detail[1], xhr = detail[2];
// })
