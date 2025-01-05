document.addEventListener('turbo:load', () => {
  const translateButton = document.getElementById('translate-button');
  if (translateButton) {
    translateButton.addEventListener('click', () => {
      const contentJapanese = document.getElementById('content_japanese').value;

      fetch('/diaries/translate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ content_japanese: contentJapanese })
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('Translation failed');
          }
          return response.json();
        })
        .then(data => {
          document.getElementById('content_english').value = data.translation;
        })
        .catch(error => {
          alert(error.message);
        });
    });
  }

  const japaneseFontSelect = document.querySelector('[name="diary[japanese_font_name]"]');
  if (japaneseFontSelect) {
    japaneseFontSelect.addEventListener('change', event => {
      const selectedJapaneseFont = event.target.value;
      document.documentElement.style.setProperty('--japanese-font', selectedJapaneseFont);
    });
  }

  const englishFontSelect = document.querySelector('[name="diary[english_font_name]"]');
  if (englishFontSelect) {
    englishFontSelect.addEventListener('change', event => {
      const selectedEnglishFont = event.target.value;
      document.documentElement.style.setProperty('--english-font', selectedEnglishFont);
    });
  }
});
