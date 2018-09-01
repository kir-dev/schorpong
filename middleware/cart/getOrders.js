var getOrders = function (id) {

    return function (req, res, next) {
        dal.Cart.find({
            user: currentUser,
            checkedOut: true
        }, null,  {sort: '-createdAt'}).populate({
            path: 'items.tool',
            select: 'name'
        }).then(function (carts) {
            req.carts = carts;
            return next();
        });
    };
};

module.exports = getOrders;
