var getTeam = function (id) {

    return function (req, res, next) {
        dal.Team.findById(req.params.id).then(function (team) {
            req.team = team;
            return next();
        });
    };
};

module.exports = getTeam;
