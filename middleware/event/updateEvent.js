var updateEvent = function (id) {

    return function (req, res, next) {
        dal.Event.findById(req.params.id, function (err, doc){
            doc.name = req.body.name;
            doc.description = req.body.description;
            doc.save();
            return next();
        });
    };
};

module.exports = updateEvent;
