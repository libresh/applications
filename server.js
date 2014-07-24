//based on https://gist.github.com/RushPL/8141755
var spdy = require('spdy'),
    crypto = require('crypto'),
    fs = require('fs'),
    config = JSON.parse(fs.readFileSync('/data/bouncer/3pp.json'));

b64decode = function(encoded) {
    return new Buffer(encoded || '', 'base64').toString('utf8');
};

var keys = {
    "key": fs.readFileSync('/data/bouncer/cert/'+config.cert+'/tls.key'),
    "cert": fs.readFileSync('/data/bouncer/cert/'+config.cert+'/tls.cert'),
    "chain": fs.readFileSync('/data/bouncer/cert/'+config.cert+'/chain.pem')
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

spdy.createServer(config.ssl,
  function(req, res) {
    console.log('proxying web '+req.url);
    proxy.web(req, res, { target: 'http://' + process.env.RESITE_PORT_80_TCP_ADDR });
    console.log('proxied web '+req.url);
  }
).listen(443);

spdy.createServer(config.ssl,
  function(req, res) {
    console.log('proxying 7678 '+req.url);
    proxy.web(req, res, { target: 'http://' + process.env.RESITE_PORT_7678_TCP_ADDR });
    console.log('proxied 7678 '+req.url);
  }
).listen(7678);

http.createServer(function(req, res) {
  console.log('request port 80', req.url);
  res.writeHead(302, {
    Location: 'https://michielbdejong.com'+req.url //todo: read this from the host header
  });
  res.end();
}).listen(80);
