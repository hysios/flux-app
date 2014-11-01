array = require("lodash-node/modern/arrays");
assign = require("lodash-node/modern/objects/assign");
mixin = require("lodash-node/modern/utilities/mixin");
defaults = require("lodash-node/modern/objects/defaults");

describe "Array Mixin", () ->
	# merge(Array, array);
	# console.log(array);

	arrayNames = ["compact",
				"difference",
				"drop",
				"findIndex",
				"findLastIndex",
				"first",
				"flatten",
				"head",
				"indexOf",
				"initial",
				"intersection",
				"last",
				"lastIndexOf",
				"object",
				"pull",
				"range",
				"remove",
				"rest",
				"sortedIndex",
				"tail",
				"take",
				"union",
				"uniq",
				"unique",
				"unzip",
				"without",
				"xor",
				"zip",
				"zipObject"]


	makeMethod = (object, name, array) ->
		object.prototype[name] = (args...) ->
			args.unshift(@)
			return array[name].apply(@, args)

	# console.log(defaults(Array.prototype, array));
	for key in arrayNames
		makeMethod(Array, key, array)

	it "find method", () ->
		a = [1,2,3]
		# console.log(a);
		console.log(a.first());