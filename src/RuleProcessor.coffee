regexes =
    trailingComma: /,\r?$/

# Based off of
# https://github.com/clutchski/coffeelint/blob/master/src/rules/no_trailing_semicolons.coffee
module.exports = class NoTrailingCommas
    rule:
        name: 'no_trailing_commas'
        level : 'error'
        message : 'Line contains a trailing comma'
        description: """
            This rule prohibits trailing commas, since they are needless
            cruft in CoffeeScript.
            <pre>
            <code>
            obj = {
                x: 1, # This comma is redundant.
                y: 2
            }
            </code>
            </pre>
            Trailing commas are forbidden by default.
            """


    lintLine: (line, lineApi) ->

        # The TERMINATOR token is extended through to the next token. As a
        # result a line with a comment DOES have a token: the TERMINATOR from
        # the last line of code.
        lineTokens = lineApi.getLineTokens()
        tokenLen = lineTokens.length
        stopTokens = ['TERMINATOR', 'HERECOMMENT']

        if tokenLen is 1 and lineTokens[0][0] in stopTokens
            return

        newLine = line
        if tokenLen > 1 and lineTokens[tokenLen - 1][0] is 'TERMINATOR'

            # `startPos` contains the end pos of the last non-TERMINATOR token
            # `endPos` contains the start position of the TERMINATOR token

            # if startPos and endPos arent equal, that probably means a comment
            # was sliced out of the tokenizer

            startPos = lineTokens[tokenLen - 2][2].last_column + 1
            endPos = lineTokens[tokenLen - 1][2].first_column
            if (startPos isnt endPos)
                startCounter = startPos
                while line[startCounter] isnt '#' and startCounter < line.length
                    startCounter++
                newLine = line.substring(0, startCounter).replace(/\s*$/, '')

        isCallStart = (token for token in lineTokens when token[0] is 'CALL_START').length > 0
        hasComma = regexes.trailingComma.test(newLine)
        [first..., last] = lineTokens
        # Don't throw errors when the contents of multiline strings,
        # regexes and the like end in ","
        if hasComma and lineApi.lineHasToken() and not isCallStart and
                not (last[0] in ['STRING', 'IDENTIFIER', 'STRING_END', 'HERECOMMENT'])
            return true
