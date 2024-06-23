function showDropdownMenu() {
    var dropdownMenu = document.getElementById("dropdownContent");
    dropdownMenu.style.display = "block";
}

function hideDropdownMenu() {
    var dropdownMenu = document.getElementById("dropdownContent");
    dropdownMenu.style.display = "none";
}

var dropdownMenu = document.getElementById("dropdownMenu");
var dropdownContent = document.getElementById("dropdownContent");

// Thêm sự kiện onmouseleave để ẩn menu khi người dùng di chuột ra khỏi vùng menu
dropdownMenu.addEventListener("mouseleave", function (event) {
    // Kiểm tra xem chuột có rời khỏi cả dropdownMenu và dropdownContent không
    if (!isMouseInElement(event, dropdownMenu) && !isMouseInElement(event, dropdownContent)) {
        hideDropdownMenu();
    }
});

// Kiểm tra xem chuột có trong phần tử không
function isMouseInElement(event, element) {
    var rect = element.getBoundingClientRect();
    return (
        event.clientX >= rect.left &&
        event.clientX <= rect.right &&
        event.clientY >= rect.top &&
        event.clientY <= rect.bottom
    );
}
