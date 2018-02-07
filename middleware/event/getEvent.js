var getEvent = function (id) {

    return function (req, res, next) {
	console.log(req.params.id);
        dal.Event.findById(req.params.id).then(function (event) {
            req.event = event;
            return next();
        });
    };
};

module.exports = getEvent;
