$(document).ready(function(){
    $(".AddToFavourite").click(function () {
        var doc = $(this);
        var Auth = doc.attr("data-userAuth");
        if (Auth == "True") {
            var productid = doc.attr("data-productid");

            $.ajax({
                url: "/Products/AddToFavourite",
                method: "POST",
                data: { "productid": productid },
                success: function () {
                    alert("წარმატებით დამატებულია");
                    window.location.reload();
                },
            })
        }
        else {
            alert("შედით სისტემაში");
        }
    })

    $(".RemoveFromFavourite").click(function () {
        var productid = $(this).attr("data-productid");

        $.ajax({
            url: "/Products/RemoveFromFavourite",
            method: "POST",
            data: { "productid": productid },
            success: function () {
                alert("წარმატებით წაიშალა");
                window.location.reload();
            },
        })
    })
})