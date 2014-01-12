require 'ostruct'
require 'active_support/core_ext/object'

# This is light-weight filtering helper class that will compose all given
# criteria (scopes). When using this class all filtering logic has to be stored
# in scopes instead of creating ad-hoc filtering objects.
#
# Usage example:
#
#     composer = ScopeComposer.new(Challenge)
#     composer.with_state = 'cancelled'
#     composer.created_during_past = '1 week'
#
# Or you can provide criteria as a second argument to new:
#
#     ScopeComposer.new(Challenge,
#       with_state: 'cancelled',
#       created_during_past: '1 week')
#
# Which translates to:
#
#     Challenge.with_state(:cancelled).created_during_past('1 week')
#
#
# If you want to call the scopes which do not take arguments, you can safely
# use them with one condition - the scope is ommited if the argument value
# given is not "1" or true.
#
# For example:
#
#     ScopeComposer.new(Challenge, accepted: false)
#
# Would not result in the scope `accepted` applied, but on the other hand
# following code would:
#
#     ScopeComposer.new(Challenge, accepted: "1")
#
module Scoping
  class ScopeComposer < OpenStruct

    # Initialize new instance with given scope and criteria table.
    #
    # @param [ActiveRecord::Base] base_scope
    # @param [Hash] table
    def initialize(base_scope, table = nil)
      @base_scope = base_scope
      @current_scope = base_scope
      @applied = false
      super({})
      @table = table if table
    end

    # Apply the scopes and return all the matching records.
    #
    # @return [ActiveRecord::Relation]
    def all
      return @current_scope.all if fields.empty?
      apply_fields_on_current_scope
    end

    # Apply the scopes and return decorated the matching records.
    #
    # @return [ActiveRecord::Relation]
    def decorate
      all.decorate
    end

    # Apply the scopes and return paginated records.
    #
    # @return [Array]
    def paginate(*args)
      apply_fields_on_current_scope
      @current_scope.paginate(*args)
    end

    # Apply the scopes and return count.
    #
    # @return [Fixnum]
    def count
      apply_fields_on_current_scope
      @current_scope.count
    end

    # Apply the scopes and return the resulting scope.
    #
    # @return [ActiveRecord::Relation]
    def scope
      apply_fields_on_current_scope
      @current_scope
    end

    private

    # Applies assigned scopes and returns the result scope.
    #
    # The scope is called only when the value (argument for scope) is non-empty
    # value.
    def apply_fields_on_current_scope
      return @current_scope if @applied
      fields.each do |field|
        value = public_send(field)
        next unless value.present?
        apply_field_on_current_scope field, value
      end
      @applied = true
      @current_scope
    end

    # Applies given scope with given argument to current scope
    #
    # @param [String] field
    # @param [Object] value
    def apply_field_on_current_scope(field, value)
      arity = @base_scope.method(field).arity
      if arity == 0
        if value == "1" || value == true
          @current_scope = @current_scope.public_send field
        end
      else
        @current_scope = @current_scope.public_send field, value
      end
    end

    # Return the filter fields.
    #
    # @return [Array]
    def fields
      @table.keys
    end

  end

end

