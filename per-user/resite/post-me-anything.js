process.umask(077);
process.env.DEBUG = true;

var http = require('http'),
    fs = require('fs'),
    mkdirp = require('mkdirp'),
    inboxpath = '/data/inbox/post-me-anything/';

function postMeAnything(req, res) {
  console.log('hit', req.url);
  var str = '';
  req.on('data', function(chunk) {
    console.log('chunk', chunk.toString());
    str += chunk.toString();
  });
  req.on('end', function() {
    var msgPath = inboxpath+(new Date()).getTime().toString();
    fs.writeFile(msgPath, new Buffer(str), function(err) {
      console.log('saved as', msgPath, str, err);
      res.writeHead(202, {
	'Access-Control-Allow-Origin': req.headers.origin || '*'
      });
      res.end('https://michielbdejong.com/blog/7.html#webmentions');
    });
  });
}

mkdirp(inboxpath, function(err1) {
        http.createServer(postMeAnything).listen(7678);
        console.log('port 7678 running');
});
console.log('port 7678 running');
