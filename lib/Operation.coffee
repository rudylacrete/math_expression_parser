AbstractMember = require './AbstractMember'
SimpleNumber = require './SimpleNumber'

module.exports = class Operation extends AbstractMember
	constructor: (v1, v2, operatorChar) ->
		if not Operation.isOperator(operatorChar)
			throw new Error 'operatorChar is not valid'
		@_value = eval("#{v1}#{operatorChar}#{v2}")
	@OPERATORS: ['+', '-', '/', '*']
	@isOperator: (char) ->
		return char in Operation.OPERATORS
	@testStr: (str) ->
		return /(\d+|\))[\+\-\*\/]/.test(str)
	@decapsulateOp: (str) ->
		return /\((.*)\)/.exec(str)[1]
