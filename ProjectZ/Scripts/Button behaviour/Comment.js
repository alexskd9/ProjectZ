$(document).ready(function () {
    $("#postNewComment").click(function () {
        var commentText = $("#newComment");
        var text = commentText.val();
        var topicId = commentText.data("topicid");
        if (text != "") {
            $.ajax({
                url: "/Topic/AddComment",
                method: "post",
                data: { "topicId": topicId, "text": text },
                success: function (response) {
                    var htmlComment = "<p style='marginn-top:5px;'><b>" + response.Author + "</b><span> (" + response.Date + ")</span> - <span>" + response.Comment + "</span>";
                    $("#commentBox").append(htmlComment);
                    commentText.val("");
                }
            })
        }
    })
})