// frontend/assets/js/script.js

// Xử lý ajax khi click Thêm vào giỏ - dùng jQuery
$('.add-to-cart').click(function() {
    // Lấy id của sp đang click
    var id = $(this).attr('data-id');
    //Tải lại trang kèm xóa cache trình duyệt: Ctrl Shift R
    var obj_ajax = {
        url: 'index.php?controller=cart&action=add',
        method: 'get',
        data: {id: id},
        success: function(data) {
            // Hiển thị thông báo cho user
            $('.ajax-message')
                .html('Thêm sp vào giỏ thành công')
                .addClass('ajax-message-active');

            // Ẩn thông báo trên tự động sau 3s
            setTimeout(function() {
                $('.ajax-message').removeClass('ajax-message-active');
            }, 3000);

            // Update số lượng sp trong giỏ hàng lên icon giỏ hàng
            var total = $('.cart-amount').html();
            total++;
            $('.cart-amount').html(total);
        }
    }
    $.ajax(obj_ajax);
})
