var getUsers = function () {

    return function (req, res, next) {
        dal.User.find({}).then(function (users) {
            req.users = users;
            return next();
        });
    };
};

module.exports = getUsers;
