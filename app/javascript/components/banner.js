import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Meet Developers", "Get Inspired", "Work Together", "Learn Forever"],
    typeSpeed: 60,
    loop: true
  });
}

export { loadDynamicBannerText };
