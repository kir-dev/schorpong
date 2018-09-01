var getCartItems = function (id) {

    return function (req, res, next) {
        dal.Cart.findOne({
            user: currentUser,
            checkedOut: false
        }).populate({
            path: 'items.tool',
            select: 'name'
        }).then(function (cart) {
            req.cart = cart;
            return next();
        });
    };
};

module.exports = getCartItems;
