document.addEventListener('turbo:load', function () {
  const btn = document.querySelector('#hamburger');
  const menu = document.querySelector('.mobile-menu');
  console.log(btn);
  btn.addEventListener('click', () => {
    menu.classList.toggle('hidden');
  });
  document.addEventListener('mouseup', function (evt) {
    targetElement = evt.target; // clicked element
    if (targetElement != menu) {
      menu.classList.add('hidden');
    }
  });
});
