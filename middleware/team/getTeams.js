var getTeams = function (id) {

    return function (req, res, next) {
        dal.Team.find({}).then(function (teams) {
            req.teams = teams;
            return next();
        });
    };
};

module.exports = getTeams;
