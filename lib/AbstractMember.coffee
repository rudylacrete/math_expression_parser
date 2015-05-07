module.exports = class Member
	constructor: ->
		@_value = null
	_type: 'AbstractNumber'
	getValue: ->
		if @_value == null
			throw new Error 'Member has no value associated'
		else
			return @_value