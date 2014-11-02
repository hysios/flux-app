path = require('path')
mkdirp = require('mkdirp')
init = require('init-package-json')
fs = require('fs')
semver = require('semver')
spawn = require('child_process').spawn

initFile = path.resolve(process.env.HOME, '.npm-init')

class CreateApplication
	constructor: (@options = {}) ->
		@path = @options.path || process.cwd()

		@fluxPath = path.resolve(__dirname + '../../../')
		@version = @options.version || @getFluxVersion()
		@packageName = path.join(@path, '/package.json')


	getFluxVersion: () ->
		pkg = require(path.resolve(__dirname + '../../../package.json'))
		pkg.version

	setup: () ->
		unless fs.exists(@packageName)
			@npmInit (err, data) =>
				@readPackage()

				@mkdir('app')
				@mkdir('app/actions')
				@mkdir('app/stores')
				@mkdir('app/fetchers')
				@mkdir('app/pages')
				
				@template('app/pages/_template.html')
				@template('app/pages/404.html')

				@mkdir('app/assets')

				@templateDir('app/assets')

				@mkdir('app/components')

				@mkdir('config')

				@template('config/environment.js')
				@mkdir('test')

				@template('.gitignore')
				@template('client.js')
				@template('server.js')

				@installDependencies('express', '4.10.1')
				@installDependencies('node-jsx', '0.12.0')
				@installDependencies('react', '0.12.0')
				@installDependencies('flux-app', @version)
				@savePackage()

				@doSystemInstall()

	doSystemInstall: () ->
		unless process.env.NODE_ENV == 'test'
			process.chdir(@path)
			cmd = spawn('npm', ['install'])
			cmd.stdout.on 'data', (data) ->
  				console.log(data.toString())

			cmd.stderr.on 'data', (data) ->
				console.log(data.toString())

	npmInit: (callback) ->
		mkdirp(@path) unless fs.exists(@path)

		configData = {
			'init-version': '0.0.1',
			'init-author-name': 'nobody',
			yes: true
		}

		init @path, initFile, configData, callback

	mkdir: (_path) ->
		@log("\x1b[36mcreated\x1b[0m : ", _path)
		mkdirp(path.join(@path, _path))

	template: (file) ->
		@copyTemplate(file, file)

	templateDir: (dir) ->
		list = fs.readdirSync(path.join(@fluxPath, 'templates', dir))

		for file in list
			@template(path.join(dir, file))

	copyTemplate: (from, to) ->
		from = path.join(@fluxPath, 'templates', from);
		@write(to, fs.readFileSync(from, 'utf-8'));
	
	write: (_path, str, mode) ->
		fs.writeFile(path.join(@path, _path), str, { mode: mode || 0o666 });
		@log('\x1b[36mcreated\x1b[0m : ' + _path)

	log: (args...) ->
		args.unshift('   ')
		console.log.apply(null, args)

	readPackage: () ->
		@pkg = require(@packageName)

	installDependencies: (name, version) ->
		@pkg.dependencies ?= {}
		unless @pkg.dependencies[name]
			@pkg.dependencies[name] = if semver.valid(version)
				"^#{version}"
			else
				version

	installDevDependencies: (name, version) ->
		@pkg.devDependencies ?= {}
		unless @pkg.devDependencies[name]
			@pkg.devDependencies[name] = "^#{version}"			

	savePackage: () ->
		fs.writeFileSync(@packageName, JSON.stringify(@pkg, null, 2) + "\n")


module.exports = createApplicationAt = (path_or_options) ->
	options = if 'string' == typeof path_or_options
		{path: path}
	else
		path_or_options

	application = new CreateApplication(options)
	application.setup()
