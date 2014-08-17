//based on https://gist.github.com/RushPL/8141755
var spdy = require('spdy'),
    crypto = require('crypto'),
    fs = require('fs'),
    config = JSON.parse(fs.readFileSync('/data/bouncer/3pp.json'));

b64decode = function(encoded) {
  return new Buffer(encoded || '', 'base64').toString('utf8');
};

var keys = {}, loadedKeys = {};

for(domain in config.certs) {
  keys[domain] = {
    "key": fs.readFileSync('/data/bouncer/cert/'+config.certs[domain]+'/tls.key'),
    "cert": fs.readFileSync('/data/bouncer/cert/'+config.certs[domain]+'/tls.cert'),
    "chain": fs.readFileSync('/data/bouncer/cert/'+config.certs[domain]+'/chain.pem')
  };
  loadedKeys[domain] = crypto.createCredentials(keys).context;
}

var spdyConfig = {
  ssl: keys['default'],
};
console.log(config, keys, spdyConfig);
spdyConfig.ssl.SNICallback = function(hostname, cb) {
  if (cb) {// 0.11.5 and later
    return cb(null, loadedKeys[hostname]);
  }
  return loadedKeys[hostname]; // 0.11.4 and earlier;
};

var http = require('http');

var httpProxy = require('http-proxy');
var proxy = httpProxy.createProxyServer({/*options*/});

function makeTarget(route) {
  var envVar = route.app.toUpperCase() + '_PORT_' + route.port + '_TCP_ADDR';
  return 'http://' + process.env[envVar] + ':' + route.port
}

function doProxy(req, res, port) {
  console.log('proxying '+port+' '+req.url);
  try {
    for (domain in config.routes[port]) {
      if (req.headers.host === domain) {
        target = makeTarget(config.routes[port][domain]);
        proxy.web(req, res, { target: target });
        console.log('proxied '+port+' '+req.url+' to '+target);
        return;
      }
    }
    target = makeTarget(config.routes[port][domain]);
    proxy.web(req, res, { target: target }) ;
    console.log('proxied '+port+' '+req.url+' to default '+target);
  } catch(e) {
    console.log('proxy fail', e);
    res.writeHead(500);
    req.end();
  }
  console.log('proxied '+port+' '+req.url);
}

function proxyPort(port) {
  spdy.createServer(spdyConfig.ssl, function(req, res) {
    return doProxy(req, res, port);
  }).listen(port);
}

//...
proxyPort(443);
proxyPort(7678);

http.createServer(function(req, res) {
  console.log('request port 80', req.url);
  if(config.redirect[req.headers.host]) {
    res.writeHead(302, {
      Location: config.redirect[req.headers.host] + req.url
    });
    res.end();
  } else {
    doProxy(req, res, 80);
  }
}).listen(80);
