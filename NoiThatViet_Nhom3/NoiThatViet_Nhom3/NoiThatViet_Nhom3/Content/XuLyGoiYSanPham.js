$(document).ready(function () {
    $('.search-input').keyup(function () {
        var searchText = $(this).val();

        // Kiểm tra nếu không có từ khóa tìm kiếm
        if (searchText.trim() === '') {
            $('.search-suggestions').empty(); // Xóa danh sách gợi ý
            return; // Kết thúc hàm khi không có từ khóa
        }

        $.ajax({
            url: '/SanPham/TimKiemSanPham',
            type: 'GET',
            dataType: 'json',
            data: { q: searchText },
            success: function (data) {
                // Xử lý dữ liệu trả về
                var suggestions = '';

                $.each(data, function (index, value) {
                    suggestions += '<li>' + value + '</li>';
                });

                $('.search-suggestions').html(suggestions);
            }
        });
    });

    // Xử lý khi người dùng xóa hết từ khóa tìm kiếm
    $('.search-input').blur(function () {
        var searchText = $(this).val();

        if (searchText.trim() === '') {
            $('.search-suggestions').empty(); // Xóa danh sách gợi ý
        }
    });
    $(document).ready(function () {
        // Xử lý khi người dùng click vào một phần tử gợi ý
        $('.search-suggestions').on('click', 'li', function () {
            var suggestionText = $(this).text().trim(); // Lấy nội dung của phần tử được click
            $('.search-input').val(suggestionText); // Đặt nội dung vào ô tìm kiếm
            $('.search-suggestions').empty(); // Xóa danh sách gợi ý sau khi chọn
        });
    });
});
