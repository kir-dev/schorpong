var deleteArticle = function () {

    return function (req, res, next) {
        dal.Article.findById(req.params.id).remove(() => {
            return next();
        });
    };
};

module.exports = deleteArticle;
