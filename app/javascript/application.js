// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', () => {
  const infoButton = document.getElementById('info-button');
  const infoPopup = document.getElementById('info-popup');
  const closeButton = document.getElementById('close-popup');

  infoButton.addEventListener('click', () => {
    infoPopup.style.display = 'block';
  });

  closeButton.addEventListener('click', () => {
    infoPopup.style.display = 'none';
  });
});