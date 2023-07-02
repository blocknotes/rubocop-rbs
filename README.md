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

- Execute rubocop
- To disable the cop:

```yml
Rbs/MethodSignature:
  Enabled: false
```

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Or consider offering me a coffee, it's a small thing but it is greatly appreciated: [about me](https://www.blocknot.es/about-me).

## Contributors

- [Mattia Roccoberton](https://blocknot.es/): author

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
