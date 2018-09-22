var getArticles = function () {

    return function (req, res, next) {
        dal.Article.find({}, null, {sort: '-createdAt'}).then(function (articles) {
            req.articles = articles;
            return next();
        });
    };
};

module.exports = getArticles;
