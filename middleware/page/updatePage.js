var updatePage = function (id) {

    return function (req, res, next) {
        console.log(req.params.id);
        dal.Page.findById(req.params.id, function (err, doc){
            doc.title = req.body.title;
            doc.content = req.body.content;
            doc.save();
            return next();
        });
    };
};

module.exports = updatePage;
