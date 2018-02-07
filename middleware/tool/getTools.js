var getTools = function (id) {

    return function (req, res, next) {
        dal.Tool.find({}).then(function (tools) {
            req.tools = tools;
            return next();
        });
    };
};

module.exports = getTools;
