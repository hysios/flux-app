require('node-jsx').install({extension: '.jsx'});
require('node-cjsx').transform();
var traceur = require('traceur');
require('traceur-source-maps').install(traceur);
traceur.require.makeDefault(function (filePath) {
  return !~filePath.indexOf('node_modules');
});


