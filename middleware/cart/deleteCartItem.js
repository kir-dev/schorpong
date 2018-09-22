var deleteCartItem = function (id) {
    return function (req, res, next) {
        dal.Cart.findOneAndUpdate({
            user: currentUser,
            checkedOut: false
        }, {$pull: {items: {tool: req.params.id}}}, (err, res) => {});
        return next();
    };
};

module.exports = deleteCartItem;
