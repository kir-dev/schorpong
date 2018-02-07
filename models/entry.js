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
        teamId: ObjectId,
        eventId: ObjectId,
        comment: String
    }, {timestamps: true});

    return Entry;

};