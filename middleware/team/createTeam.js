var createTeam = function (id) {

    return function (req, res, next) {
        dal.Team.create({
            name: req.body.name,
            description: req.body.description
        }, function () {
            return next();
        });
    };
};

module.exports = createTeam;
