var getEntries = function (id) {

    return function (req, res, next) {
        dal.Entry.find({}).then(function (entries) {
            req.entries = entries;
            return next();
        });
    };
};

module.exports = getEntries;
