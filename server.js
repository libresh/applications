//based on https://gist.github.com/RushPL/8141755
var spdy = require('spdy'),
    crypto = require('crypto'),
    fs = require('fs');

b64decode = function(encoded) {
    return new Buffer(encoded || '', 'base64').toString('utf8');
};

var keys = {
    "key": fs.readFileSync('/data/cell/cert/blog.michielbdejong.com/tls.key'),
    "cert": fs.readFileSync('/data/cell/cert/blog.michielbdejong.com/tls.cert'),
    "chain": fs.readFileSync('/data/cell/cert/blog.michielbdejong.com/chain.pem')
};
var loadedKeys = crypto.createCredentials(keys).context;

var config = {
    ssl: keys,
};

config.ssl.SNICallback = function(hostname, cb) {
    if (cb) // 0.11.5 and later
        return cb(null, loadedKeys);
    return loadedKeys; // 0.11.4 and earlier;
};

var http = require('http');

var httpProxy = require('http-proxy');
var proxy = httpProxy.createProxyServer({/*options*/});

var server = spdy.createServer(config.ssl,
    function(req, res) {
      proxy.web(req, res, { target: 'http://localhost:801' });
    }
).listen(443);

http.createServer(function(req, res) {
  console.log('request port 80', req.url);
  res.writeHead(302, {
    Location: 'https://michielbdejong.com'+req.url //todo: read this from the host header
  });
  res.end();
}).listen(80);
