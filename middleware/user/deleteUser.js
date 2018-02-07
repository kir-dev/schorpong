var deleteUser = function (id) {

    return function (req, res, next) {
        dal.User.findById(req.params.id).remove(function (user) {
            return next();
        });
    };
};

module.exports = deleteUser;
