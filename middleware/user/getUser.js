var getUser = function (id) {

    return function (req, res, next) {
        dal.User.findById(req.params.id).then(function (user) {
            req.user = user;
            return next();
        });
    };
};

module.exports = getUser;
