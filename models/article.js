module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Article = new mongoose.Schema({

        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        image: String,
        title: String,
        intro: String,
        content: String
    }, {timestamps: true});

    Article.virtual('date').get(function() {
        return moment(this.createdAt).fromNow();
    });

    return Article;

};