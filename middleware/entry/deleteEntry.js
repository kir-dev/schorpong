var deleteEntry = function (id) {

    return function (req, res, next) {
        dal.Entry.findById(req.params.id).remove(function (tool) {
            return next();
        });
    };
};

module.exports = deleteEntry;
