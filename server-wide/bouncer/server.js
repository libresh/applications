//based on https://gist.github.com/RushPL/8141755
var spdy = require('spdy'),
    crypto = require('crypto'),
    fs = require('fs');

b64decode = function(encoded) {
  return new Buffer(encoded || '', 'base64').toString('utf8');
};

var keys = {}, loadedKeys = {};
var domains = fs.readdirSync('/data/per-user');
for (domain in domains) {
  try {
    keys[domain] = {
      "key": fs.readFileSync('/data/per-user/'+domain+'/bouncer/cert/tls.key'),
      "cert": fs.readFileSync('/data/per-user/'+domain+'/bouncer/cert/tls.cert'),
      "chain": fs.readFileSync('/data/per-user/'+domain+'/bouncer/cert/chain.pem')
    };
    loadedKeys[domain] = crypto.createCredentials(keys[domain]).context;
  } catch(e) {
    console.log('failed to load certs from /data/per-user/'+domain+'/bouncer/cert');
  }
}

var spdyConfig = {
  ssl: keys['default'],
};

console.log(keys, spdyConfig);
spdyConfig.ssl.SNICallback = function(hostname, cb) {
  console.log('SNI', hostname);
  if (cb) {// 0.11.5 and later
    return cb(null, loadedKeys[hostname]);
  }
  return loadedKeys[hostname]; // 0.11.4 and earlier;
};

var http = require('http');

var httpProxy = require('http-proxy');
var proxy = httpProxy.createProxyServer({/*options*/});

function makeTarget(image, domain, portTo) {
  var envVar = image.toUpperCase() + '-' + domain.toUpperCase() + '_PORT_' + portTo + '_TCP_ADDR';
  return 'http://' + process.env[envVar] + ':' + portTo;
}

function doProxy(req, res, image, portTo) {
  var domain = 'default';
  try {
    if (loadedKeys[req.headers.host]) {
      domain = req.headers.host;
    }
    console.log('proxying to ' + image + ' port ' + portTo + ' ' + req.url + ' for ' + domain);
    target = makeTarget(image, domain, portTo);
    proxy.web(req, res, { target: target });
    console.log('proxied ' + port + ' ' + req.url + ' to ' + target);
  } catch (e) {
    console.log('proxy fail', e);
    res.writeHead(500);
    req.end();
  }
  console.log('proxied ' + port + ' ' + req.url);
}

function proxyPort(portExt, image, portTo) {
  spdy.createServer(spdyConfig.ssl, function(req, res) {
    return doProxy(req, res, image, portTo);
  }).listen(portExt);
}

//...
proxyPort(443, 'resite', 80);
proxyPort(7678, 'resite', 7678);

http.createServer(function(req, res) {
  console.log('request port 80', req.url, req.headers.host);
  if (loadedKeys[req.headers.host]) {
    res.writeHead(302, {
      Location: 'https://' + req.headers.host + '/' + req.url
    });
    res.end();
  } else {//no TLS cert for this host! fall back to serving over http
    doProxy(req, res, 'resite', 80);
  }
}).listen(80);
