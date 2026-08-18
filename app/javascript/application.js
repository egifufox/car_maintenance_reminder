// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

// パスワード表示/非表示切り替え機能
document.addEventListener('turbo:load', function() {
  // ログインページ用: パスワードフィールドの表示/非表示切り替え
  const togglePassword = document.getElementById('toggle-password');
  const passwordField = document.getElementById('password-field');
  const togglePasswordIcon = document.getElementById('toggle-password-icon');
  
  if (togglePassword && passwordField && togglePasswordIcon) {
    togglePassword.addEventListener('click', function() {
      const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordField.setAttribute('type', type);
      
      if (type === 'password') {
        togglePasswordIcon.classList.remove('bi-eye-slash');
        togglePasswordIcon.classList.add('bi-eye');
      } else {
        togglePasswordIcon.classList.remove('bi-eye');
        togglePasswordIcon.classList.add('bi-eye-slash');
      }
    });
  }
  
  // 新規登録ページ用: パスワード確認フィールドの表示/非表示切り替え
  const togglePasswordConfirmation = document.getElementById('toggle-password-confirmation');
  const passwordConfirmationField = document.getElementById('password-confirmation-field');
  const togglePasswordConfirmationIcon = document.getElementById('toggle-password-confirmation-icon');
  
  if (togglePasswordConfirmation && passwordConfirmationField && togglePasswordConfirmationIcon) {
    togglePasswordConfirmation.addEventListener('click', function() {
      const type = passwordConfirmationField.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordConfirmationField.setAttribute('type', type);
      
      if (type === 'password') {
        togglePasswordConfirmationIcon.classList.remove('bi-eye-slash');
        togglePasswordConfirmationIcon.classList.add('bi-eye');
      } else {
        togglePasswordConfirmationIcon.classList.remove('bi-eye');
        togglePasswordConfirmationIcon.classList.add('bi-eye-slash');
      }
    });
  }
});