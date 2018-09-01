var createEvent = function (id) {

    return function (req, res, next) {
        dal.Event.create({
            name: req.body.name,
            image: req.file.filename,
            description: req.body.description
        }, function () {
            return next();
        });
    };
};

module.exports = createEvent;
