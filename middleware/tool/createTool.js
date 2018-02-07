var createTool = function (id) {

    return function (req, res, next) {
        dal.Tool.create({
            name: req.body.name,
            description: req.body.description
        }, function () {
            return next();
        });
    };
};

module.exports = createTool;
