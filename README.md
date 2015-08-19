# coffeelint-no-trailing-commas

CoffeeLint rule that disallows trailing commas

## Description

This [CoffeeLint](http://www.coffeelint.org/) rule disallows trailing commas.

## Installation

```sh
npm install coffeelint-no-implicit-returns
```

## Usage

Add the following configuration to `coffeelint.json`:

```json
"no_trailing_commas": {
  "module": "coffeelint-no-trailing-commas"
}
```

## Configuration

There are currently no configuration options.

## Testing

To run tests:

```
~/coffeelint-no-trailing-commas]$ npm run test

> coffeelint-no-trailing-commas@1.0.1 test /Users/jasonku/coffeelint-no-trailing-commas
> coffee vowsrunner.coffee --spec test/RuleProcessor.test.coffee


  ♢ no_trailing_commas

...

✓ OK » 3 honored (0.083s)
```