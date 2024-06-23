document.addEventListener('DOMContentLoaded', function () {
    const inputs = document.querySelectorAll('.form-group input');
    inputs.forEach(input => {
        input.addEventListener('focus', function () {
            this.previousElementSibling.style.fontSize = '0.6rem';
            this.previousElementSibling.style.top = '0.2rem';
            this.previousElementSibling.style.left = '0.7rem';
        });
        input.addEventListener('blur', function () {
            if (this.value === '') {
                this.previousElementSibling.style.fontSize = '0.8rem';
                this.previousElementSibling.style.top = '0.5rem';
                this.previousElementSibling.style.left = '1rem';
            }
        });
    });
});