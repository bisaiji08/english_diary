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

document.addEventListener('DOMContentLoaded', () => {
  const logoutLink = document.getElementById('logout-link');

  if (logoutLink) {
    logoutLink.addEventListener('click', (event) => {
      event.preventDefault(); // デフォルトの動作を防ぐ

      // ログアウト処理を実行
      fetch(logoutLink.href, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      })
      .then(response => {
        if (response.ok) {
          // 成功したらstatic_pages#topに移動
          window.location.href = '/'; // ルートパスにリダイレクト
        } else {
          // エラーハンドリング
          console.error('ログアウトに失敗しました');
        }
      });
    });
  }
});