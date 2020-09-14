$(document).ready(function () {
    $(".changeQty").click(function () {
        var element = $(this);
        var CartProductId = element.data("cartproductid");
        var opType = element.data("operation");
        var minus = element.siblings(".minusProduct");
        var qtyEl = element.parent().siblings(".quantity");
        if (qtyEl == 2 && element.hasClass("minusProduct")) {
            element.hide();
        }
        if (qtyEl.html() > 0) {
            minus.show();
        }
        $.ajax({
            url: "/Products/ChangeProductQty",
            method: "post",
            data: { "cartProductId": CartProductId, "opType": opType },
            success: function (response) {
                element.parent().siblings(".quantity").html(response.Quantity);
                element.parent().siblings(".price").html(response.Sum);
                $("#totalAmount").html(response.cartAmount);
            }
        })
    })

    $(".removeProduct").click(function () {
        var element = $(this);
        var CartProductId = element.data("cartproductid");
        $.ajax({
            url: "/Products/RemoveFromCart",
            method: "post",
            data: { "cartProductId": CartProductId },
            success: function (response) {
                element.parent().parent().hide;
                window.location.reload();
                $("#totalAmount").html(response.cartAmount);
            }
        })
    })
})