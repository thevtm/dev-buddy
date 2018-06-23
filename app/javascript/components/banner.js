import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Meet other nerds around you", "Get inspired", "Collaborate", "Learn"],
    typeSpeed: 60,
    loop: true
  });
}

export { loadDynamicBannerText };
