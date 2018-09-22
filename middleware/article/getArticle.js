var getArticle = function () {

    return function (req, res, next) {
        dal.Article.findById(req.params.id).then(function (article) {
            req.article = article;
            return next();
        });
    };
};

module.exports = getArticle;
