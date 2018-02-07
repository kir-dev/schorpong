module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Loan = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        userId: ObjectId,
        toolId: ObjectId,
        quantity: Number,
        comment: String
    }, {timestamps: true});

    return Loan;
};