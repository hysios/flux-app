var path = require('path');
var fs = require('fs');
var execFile = require('child_process').execFile;
var exec = require('child_process').exec;
var tmp = require('tmp');
var should = require('should');

describe("test flux binary", function() {
	var bin = path.resolve('./bin/flux');

	it("init new path", function(done) {
		tmp.dir({unsafeCleanup: true}, function(err, _path, cleanupCallback) {
			var command = bin + ' init ' + _path;
			exec(command, function(err, stdout, stderr) {
				// cleanupCallback();
				should(fs.existsSync(path.join(_path, 'package.json'))).be.true;
				cleanupCallback();
 				done();
			});
		});
	});

	it("package have a flux-app dependencies", function(done) {
		tmp.dir({unsafeCleanup: true}, function(err, _path, cleanupCallback) {
			var command = bin + ' init ' + _path;
			exec(command, function(err, stdout, stderr) {
				// cleanupCallback();
				var pkg = require(path.join(_path, 'package.json'));
				console.log(pkg);
				should(pkg.dependencies['flux-app']).be.ok;
				cleanupCallback();
 				done();
			});
		});
	});	
});