var createLoan = function (id) {

    return function (req, res, next) {
        dal.Loan.create({
            name: req.body.name,
            description: req.body.description
        }, function () {
            return next();
        });
    };
};

module.exports = createLoan;
