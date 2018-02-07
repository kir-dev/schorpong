var deleteArticle = function (id) {

    return function (req, res, next) {
        dal.Article.findById(req.params.id).remove(function (article) {
            return next();
        });
    };
};

module.exports = deleteArticle;
