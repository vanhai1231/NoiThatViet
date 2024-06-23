$(document).ready(function () {
    toastr.options = {
        "closeButton": true,
        "positionClass": "toast-bottom-right",
        "progressBar": true,
        "timeOut": "3000", // 3s
    };
    $(".deleteFromWishlist").click(function () {
        var productId = $(this).data("product-id");
        var cardToRemove = $(this).closest(".col-md-3");
        $.ajax({
            url: "/SanPham/DeleteFromWishlist", // Change this URL to your actual delete endpoint
            type: "POST",
            data: { id: productId },
            success: function (result) {
                if (result.success) {
                    // Remove the card from the DOM upon successful deletion
                    cardToRemove.remove();
                    toastr.success("Đã xóa vật phẩm!");
                } else {
                    toastr.error(result.message);
                }
            },
            error: function (xhr, status, error) {
                toastr.error("Đã có lỗi khi xóa sản phẩm: " + error);
            }
        });
    });
});