var getTool = function (id) {

    return function (req, res, next) {
	console.log(req.params.id);
        dal.Tool.findById(req.params.id).then(function (tool) {
            req.tool = tool;
            return next();
        });
    };
};

module.exports = getTool;
