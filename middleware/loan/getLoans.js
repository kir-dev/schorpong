var getLoans = function (id) {

    return function (req, res, next) {
        dal.Loan.find({}).then(function (loans) {
            req.loans = loans;
            return next();
        });
    };
};

module.exports = getLoans;
