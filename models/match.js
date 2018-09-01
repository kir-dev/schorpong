module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Match = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        home: { type: Schema.Types.ObjectId, ref: 'Team' },
        away: { type: Schema.Types.ObjectId, ref: 'Team' },
        category: { type: Schema.Types.ObjectId, ref: 'MatchCategory' },
        event: { type: Schema.Types.ObjectId, ref: 'Event' },
        result: String
    }, {timestamps: true});

    return Match;
};
