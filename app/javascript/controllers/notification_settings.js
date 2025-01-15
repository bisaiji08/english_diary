document.addEventListener("turbo:load", () => {
  const enableCheckbox = document.getElementById("enable-notifications");
  const disableCheckbox = document.getElementById("disable-notifications");

  if (!enableCheckbox || !disableCheckbox) return;

  // 初期状態を同期
  disableCheckbox.checked = !enableCheckbox.checked;

  // Enable チェックボックスの動作
  enableCheckbox.addEventListener("change", () => {
    disableCheckbox.checked = !enableCheckbox.checked;
  });

  // Disable チェックボックスの動作
  disableCheckbox.addEventListener("change", () => {
    enableCheckbox.checked = !disableCheckbox.checked;
  });
});
