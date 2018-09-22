var updateArticle = function () {

    return function (req, res, next) {
        dal.Article.findById(req.params.id, function (err, doc){
            doc.title = req.body.title;
            doc.intro = req.body.intro;
            doc.content = req.body.content;
            doc.save();
            return next();
        });
    };
};

module.exports = updateArticle;
