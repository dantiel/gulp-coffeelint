'use strict'

through2 = require 'through2'
stylish = require 'coffeelint-stylish'
{createPluginError} = require './utils'

defaultReporter = ->
    through2.obj (file, enc, cb) ->
        # nothing to report or no errors
        if not file.coffeelint or file.coffeelint.success
            @push file
            return cb()

        # report
        stylish.reporter file.relative, file.coffeelint.results

        # pass along
        @push file
        cb()

failReporter = ->
    through2.obj (file, enc, cb) ->
        # nothing to report or no errors
        if not file.coffeelint or file.coffeelint.success
            @push file
            return cb()

        # fail
        @emit 'error', new Error "CoffeeLint failed for #{file.relative}"
        cb()

reporter = (type = 'default') ->
    return defaultReporter() if type is 'default'
    return failReporter() if type is 'fail'

    # Otherwise
    throw createPluginError "#{type} is not a valid reporter"

module.exports = reporter
