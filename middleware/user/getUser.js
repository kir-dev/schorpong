var getUser = function (id) {

    return function (req, res, next) {
        dal.User.findById(req.params.id)
            .populate({
                path: 'memberships',
                select: 'name team',
                populate : {
                    path : 'team',
                    select: 'name'
                }
            })
            .then(function (user) {
                req.user = user;
                return next();
            });
    };
};

module.exports = getUser;
