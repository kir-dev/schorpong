module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var MatchCategory = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        name: String,
        matches: [{type: Schema.Types.ObjectId, ref: 'Match'}]
    }, {timestamps: true});

    return MatchCategory;
};
