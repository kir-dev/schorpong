var createArticle = function (id) {

    return function (req, res, next) {
        dal.Article.create({
            title: req.body.title,
            intro: req.body.intro,
            content: req.body.content
        }, function () {
            return next();
        });
    };
};

module.exports = createArticle;
