# RuboCop RBS

[![Gem Version](https://badge.fury.io/rb/rubocop-rbs.svg)](https://badge.fury.io/rb/rubocop-rbs)

RucoCop extension that check RBS signatures.

> DISCLAIMER: this extension is an ALPHA version, it could be not 100% stable

Check for:
- invalid RBS files;
- missing RBS method signatures;
- mismatching RBS method signatures arguments.

Please ⭐ if you like it.

**Know limitations**: some IDEs don't update the RBS cops offenses in real-time when a change is applied because only the .rb files are actively monitored.

## Install

- Add to _Gemfile_: `gem 'rubocop-rbs'` (and execute bundle);
- Add to _.rubocop.yml_:

```yml
require:
  - rubocop-rbs
```

## Usage

- Execute rubocop: `bundle exec rubocop`
- To skip the cop from some files:

```yml
Rbs/MethodSignature:
  Exclude:
    - main.rb
```

## Offenses

- _Rbs/MethodSignature: signature error_: one or more signature errors in a RBS file:

```
main.rb:7:3: C: Rbs/MethodSignature: signature error, sig/main.rbs:1:0...1:3: Syntax error: cannot start a declaration, token=def (kDEF)
  def test_required_positionals(key1, key2); end
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

- _Rbs/MethodSignature: missing signature_: method signature not found in the RBS files:

```
main.rb:7:3: C: Rbs/MethodSignature: missing signature
  def test_required_positionals(key1, key2); end
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

- _Rbs/MethodSignature: signature mismatch_: method signature has different arguments from the one defined in the RBS files:

```
main.rb:7:3: C: Rbs/MethodSignature: signature mismatch, expected: (untyped, untyped, untyped) -> void
  def test_required_positionals(key1, key2); end
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Or consider offering me a coffee, it's a small thing but it is greatly appreciated: [about me](https://www.blocknot.es/about-me).

## Contributors

- [Mattia Roccoberton](https://blocknot.es/): author

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
