module.exports.getDockerOptions = function(host, application, envVars, MbOfRAM, localDataPath) {
  var envVarArr = [];
  for (var i in envVars) {
    envVarArr.push(i + '=' + envVars[i]);
  }
  return {
    createOptions: {
      Image: 'indiehosters/' + application,
      name: host,
      Hostname: host,
      Memory: MbOfRAM * 1024 * 1024,
      MemorySwap: -1,
      Env: envVarArr
    },
    startOptions: {
      Binds: [ localDataPath + '/' + application + ':/data' ]
    }
  };
};
