module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Entry = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },

        team: {
            type: Schema.Types.ObjectId,
            ref: 'Team'
        },
        event: {
            type: Schema.Types.ObjectId,
            ref: 'Event'
        },
        comment: String
    }, {timestamps: true});

    return Entry;

};