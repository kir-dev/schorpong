var updateTool = function (id) {

    return function (req, res, next) {
        dal.Tool.findById(req.params.id, function (err, doc){
            doc.name = req.body.name;
            doc.description = req.body.description;
            doc.save();
            return next();
        });
    };
};

module.exports = updateTool;
