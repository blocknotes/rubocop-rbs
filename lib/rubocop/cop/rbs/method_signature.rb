# frozen_string_literal: true

module RuboCop
  module Cop
    module Rbs
      # Check for:
      # - invalid RBS files;
      # - missing RBS method signatures;
      # - mismatching RBS method signatures arguments.
      class MethodSignature < Cop
        MSG = 'signature mismatch'

        def on_def(node)
          methods = module_methods(node.parent_module_name)
          return unless methods
          return add_offense(node, message: 'missing signature') unless methods.key?(node.method_name)

          result = check_arity(node, methods[node.method_name].method_types)
          add_offense(node, message: result) if result
        rescue RBS::BaseError => e
          add_offense(node, message: "signature error, #{e}")
        end
        alias on_defs on_def

        private

        def module_methods(module_name)
          return if module_name.nil?

          type = rbs_resolver.resolve(rbs_type_name(module_name), context: nil)
          return unless type

          rbs_builder.build_instance(type).methods
        end

        def rbs_type_name(string)
          RBS::Namespace.parse(string).yield_self do |namespace|
            last = namespace.path.last
            RBS::TypeName.new(name: last, namespace: namespace.parent)
          end
        end

        def rbs_environment
          @@rbs_environment ||= begin
            loader = RBS::EnvironmentLoader.new
            loader.add(path: Pathname('sig')) # TODO: use configuration var for sig path
            RBS::Environment.from_loader(loader).resolve_type_names
          end
        end

        def rbs_resolver
          @@rbs_resolver ||= RBS::Resolver::TypeNameResolver.new(rbs_environment)
        end

        def rbs_builder
          @@rbs_builder ||= RBS::DefinitionBuilder.new(env: rbs_environment)
        end

        def check_arity(node, method_args)
          arity = node.arguments.entries.map(&:type).tally
          rbs_args = method_args.first.type
          return if arity_match?(arity, rbs_args)

          "#{MSG}, expected: #{method_args.join("\n")}"
        end

        def arity_match?(arity, rbs_args)
          arity_arg_match?(arity, rbs_args) &&
            arity_optarg_match?(arity, rbs_args) &&
            arity_restarg_match?(arity, rbs_args) &&
            arity_kwarg_match?(arity, rbs_args) &&
            arity_kwoptarg_match?(arity, rbs_args) &&
            arity_kwrestarg_match?(arity, rbs_args)
        end

        def arity_arg_match?(arity, rbs_args)
          arity[:arg].to_i == (rbs_args.required_positionals.count + rbs_args.trailing_positionals.count)
        end

        def arity_optarg_match?(arity, rbs_args)
          arity[:optarg].to_i == rbs_args.optional_positionals.count
        end

        def arity_restarg_match?(arity, rbs_args)
          arity[:restarg].to_i.positive? == !rbs_args.rest_positionals.nil?
        end

        def arity_kwarg_match?(arity, rbs_args)
          arity[:kwarg].to_i == rbs_args.required_keywords.count
        end

        def arity_kwoptarg_match?(arity, rbs_args)
          arity[:kwoptarg].to_i == rbs_args.optional_keywords.count
        end

        def arity_kwrestarg_match?(arity, rbs_args)
          arity[:kwrestarg].to_i.positive? == !rbs_args.rest_keywords.nil?
        end
      end
    end
  end
end
