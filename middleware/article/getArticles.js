var getArticles = function (id) {

    return function (req, res, next) {
        dal.Article.find({}).then(function (articles) {
            req.articles = articles;
            return next();
        });
    };
};

module.exports = getArticles;
