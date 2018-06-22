import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Easy and Fast way to", "Meet the nerds around you"],
    typeSpeed: 70,
    loop: true
  });
}

export { loadDynamicBannerText };
