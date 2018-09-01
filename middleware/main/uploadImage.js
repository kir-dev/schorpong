var multer  = require('multer')
var upload = multer({ dest: './upload/' })
var sharp = require('sharp')

module.exports = function () {
    return function (req, res, next) {
        if(req.file) {
            console.log('asdasd');
            sharp(req.file.path).webp({quality: 96}).resize(512, 512).toFile('./public/img/'+req.file.filename, (err, info) => {
                return next();
           });
        } else {

            console.log('HIBAAA');
            // TODO: Throw validation error
            return next();
        }
    };
};

