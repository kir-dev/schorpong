var deleteTool = function (id) {

    return function (req, res, next) {
        dal.Tool.findById(req.params.id).remove(function (tool) {
            return next();
        });
    };
};

module.exports = deleteTool;
