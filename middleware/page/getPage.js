var getPage = function (id) {

    return function (req, res, next) {
        dal.Page.findOne({ name: req.params.name } ).then(function (page) {
            req.page = page;
            return next();
        });
    };
};

module.exports = getPage;
