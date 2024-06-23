function checkPasswordStrength() {
    var password = document.getElementById("password").value;
    var passwordStrengthRow = document.getElementById("password-strength-row");
    var weakBar = document.getElementById("weak-bar");
    var mediumBar = document.getElementById("medium-bar");
    var strongBar = document.getElementById("strong-bar");
    var passwordStrength = document.getElementById("password-strength");

    // Kiểm tra độ dài của mật khẩu và sự đa dạng của các ký tự
    var uniqueChars = new Set(password).size; // Số kí tự duy nhất trong mật khẩu
    var isRepeatedChars = /^(.)\1+$/.test(password); // Kiểm tra xem các ký tự có giống nhau không
    if (password.length == "") {
        passwordStrength.innerHTML = ""; // Clear password strength text
        passwordStrengthRow.style.display = "none";
    }
    else if (password.length < 4 ) {
        passwordStrength.innerHTML = "Rất yếu";
        weakBar.style.width = "0%";
        mediumBar.style.width = "0%";
        strongBar.style.width = "0%";
        passwordStrengthRow.style.display = "";
    } else if (password.length < 6 || isRepeatedChars) {
        passwordStrength.innerHTML = "Yếu";
        weakBar.style.width = "100%";
        mediumBar.style.width = "0%";
        strongBar.style.width = "0%";
        passwordStrengthRow.style.display = ""; // Show password strength row
    } else if (password.length >= 8 && password.length <= 10 && /[a-z]/.test(password) && /[A-Z]/.test(password) && /.*\d.*/.test(password) && /[^a-zA-Z0-9]/.test(password)) {
        passwordStrength.innerHTML = "Trung bình";
        weakBar.style.width = "100%";
        mediumBar.style.width = "100%";
        strongBar.style.width = "0%";
        passwordStrengthRow.style.display = ""; // Show password strength row
    } else if (password.length >= 10 && uniqueChars > 5 ) {
        passwordStrength.innerHTML = "Mạnh";
        weakBar.style.width = "100%";
        mediumBar.style.width = "100%";
        strongBar.style.width = "100%";
        passwordStrengthRow.style.display = ""; // Show password strength row
    }
}

document.getElementById("password").addEventListener("input", checkPasswordStrength);
