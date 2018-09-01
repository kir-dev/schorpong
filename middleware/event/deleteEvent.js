var deleteEvent = function (id) {

    return function (req, res, next) {
        console.log(req.params.id);
        dal.Event.findById(req.params.id).remove(function (event) {
            return next();
        });
    };
};

module.exports = deleteEvent;
