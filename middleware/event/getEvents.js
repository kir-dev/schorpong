var getEvents = function (id) {

    return function (req, res, next) {
        dal.Event.find({}).then(function (events) {
            req.events = events;
            return next();
        });
    };
};

module.exports = getEvents;
