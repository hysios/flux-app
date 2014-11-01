module.exports = {
	capitalize: (string) ->
		strs = string.split(/-|_|\s/);
		return strs.map (s) ->
			return s.substr(0, 1).toUpperCase() + s.substring(1).toLowerCase();
}