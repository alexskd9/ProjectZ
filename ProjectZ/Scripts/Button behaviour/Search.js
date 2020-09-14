$(document).ready(function () {
    $("#searchField").keyup(function () {
        var searchItem = $(this);
        $.ajax({
            url: "/Products/Search",
            method: "post",
            data: { "searchItem": searchItem.val() },
            success: function (response) {
                $("#suggestions").remove();
                var htmlItem = "<ol style='list-style:none'; id='suggestions';>";
                $.each(response, function (index, value) {
                    htmlItem += "<li><a href='/Products/Details/" + value.Id + "'>" + value.Name + "</a></li><br/>";
                });
                htmlItem += "</ol>";
                searchItem.after(htmlItem);
            }
        })
    })
})