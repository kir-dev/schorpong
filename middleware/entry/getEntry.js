var getEntry = function (id) {

    return function (req, res, next) {
        console.log(req.params.id);
        dal.Entry.findById(req.params.id).then(function (tool) {
            req.tool = tool;
            return next();
        });
    };
};

module.exports = getEntry;
