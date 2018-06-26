var myElement2 = document.querySelector('.invisible-layer');
var myOptions2 = {}
var submitForm = document.getElementById('submit-form');
var containerForm = document.querySelector('.container-form');
var submitButton = document.getElementById('submit-button');

if (submitButton) {
  var hammertime2 = new Hammer(myElement2, myOptions2);
  hammertime2.get('swipe').set({ direction: Hammer.DIRECTION_ALL });


  var swipeToSubmit = hammertime2.on('swipeup',
    function(v) {
      v.preventDefault();
      console.log('swipeup')
      containerForm.classList.add('animated', 'slideOutUp')
      $(containerForm).on('animationend', () => {
        console.log('submit form')
        $(submitButton).click()
      });
  });
}




// var swipeToSubmit = hammertime2.on('tap',
//   function(v) {
//     v.preventDefault();
//     console.log('swipeup')
//     containerForm.classList.add('animated', 'zoomOutUp')
//     submitForm.addEventListener('submit', function(evt) {
//       submitForm.submit();
//     };
//     console.log('form submited')
// });
