var createArticle = function (id) {

    return function (req, res, next) {
        dal.Article.create({
            title: req.body.title,
            image: req.file.filename,
            intro: req.body.intro,
            content: req.body.content
        }, function () {
            return next();
        });
    };
};

module.exports = createArticle;
