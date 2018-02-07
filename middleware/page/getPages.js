var getPages = function (id) {

    return function (req, res, next) {
        dal.Page.find({}).then(function (pages) {
            req.pages = pages;
            return next();
        });
    };
};

module.exports = getPages;
