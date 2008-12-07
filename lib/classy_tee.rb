module ClassyTee
  module ActsMethods
    def classy_tee!
      foreign_key = "#{self.name.underscore}_id"
      association = "#{self.name}Extension".constantize
      association_key = association.name.underscore.to_sym
      cti_columns = association.column_names - ["id", foreign_key, "created_at", "updated_at"]
      
      has_one association_key, :foreign_key => foreign_key
      has_one_accessor association_key, cti_columns, :prefix => false
      default_scope(:include => association_key) if self.respond_to?(:default_scope)
    end
  end
end