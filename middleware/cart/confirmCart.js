var confirmCart = function (id) {

    return function (req, res, next) {
        dal.Cart.findOne({
            user: currentUser,
            checkedOut: false
        }).then(function (cart) {
            cart.checkedOut = true;
            cart.save();
            return next();
        });
    }
};

module.exports = confirmCart;
