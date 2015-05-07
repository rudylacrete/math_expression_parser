AbstractMember = require './AbstractMember'

module.exports = class SimpleNumber extends AbstractMember
	constructor: (str) ->
		@_value = parseInt(str)
	@testStr: (str) ->
		return /^\d+$/.test(str)