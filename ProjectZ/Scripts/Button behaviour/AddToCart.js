$(document).ready(function () {
    $(".AddToCart").click(function () {
        var doc = $(this);
        var Auth = doc.attr("data-userAuth");
        if (Auth == "True") {
            var productid = doc.attr("data-productid");

            $.ajax({
                url: "/Products/AddToCart",
                method: "POST",
                data: { "productid": productid },
                success: function (response) {
                    $("#CartPrice").html(response + " ₾");
                    alert("დამატებულია კალათაში");
                },
            })
        }
        else {
            alert("შედით სისტემაში");
        }
        
    })
})