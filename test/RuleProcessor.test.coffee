vows = require 'vows'
assert = require 'assert'
coffeelint = require 'coffeelint'
_ = require 'lodash'

defaultConfig = {}

configError = _.extend {}, defaultConfig,
    no_trailing_commas:
        module: 'src/RuleProcessor'

vows.describe('no_trailing_commas').addBatch(
    'No trailing commas':

        'should not warn when not enabled': ->
            assert.isEmpty(coffeelint.lint("""
            foo: ->
              array = [
                one: 1
                two: 2,
                three: 3
              ]
            """, defaultConfig))

        'should warn when enabled': ->
            result = coffeelint.lint("""
            foo: ->
              array = [
                one: 1
                two: 2,
                three: 3
              ]
            """, configError)
            assert.equal(result.length, 1)
            assert.equal(result[0].rule,  'no_trailing_commas')
            assert.equal(result[0].level, 'error')

        'should not warn for single line comments': ->
            result = coffeelint.lint("""
            foo: ->
              array = [
                one: 1
                # two: 2,
                three: 3
              ]
            """, configError)
            assert.isEmpty(result)

).export(module)
