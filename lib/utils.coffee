'use strict'

{PluginError} = require 'gulp-util'

exports.isLiterate = (file) ->
    /\.(litcoffee|coffee\.md)$/.test file

exports.createPluginError = (message) ->
    new PluginError 'gulp-coffeelint', message

exports.formatOutput = (results, opt, literate) ->
    errs = 0
    warns = 0

    # some counting
    results.map (result) ->
        {level} = result
        errs++ if level is 'error'
        warns++ if level is 'warn'

    # output
    success: if results.length is 0 then true else false
    results: results
    errorCount: errs
    warningCount: warns
    opt: opt
    literate: literate
