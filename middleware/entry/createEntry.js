var createEntry = function (id) {

    return function (req, res, next) {
        dal.Entry.create({
            name: req.body.name,
            description: req.body.description
        }, function () {
            return next();
        });
    };
};

module.exports = createEntry;
