require 'rails_generator/generators/components/model/model_generator'
class ClassyTeeGenerator < ModelGenerator

  def initialize(runtime_args, runtime_options = {})
    args = runtime_args.dup
    base_name = args.shift
    return usage unless base_name
    args.unshift("#{base_name.underscore}_id:integer")
    args.unshift("#{base_name}Extension")
    super(args, runtime_options)
  end
  
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, class_name

      # Model, spec, and fixture directories.
      m.directory File.join('app/models', class_path)
      m.directory File.join('test/models', class_path)
      m.directory File.join('test/fixtures', class_path)

      # Model class, spec and fixtures.
      m.template 'model:model.rb',      File.join('app/models', class_path, "#{file_name}.rb")
      m.template 'model:fixtures.yml',  File.join('test/fixtures', class_path, "#{table_name}.yml")
      m.template 'model:unit_test.rb',  File.join('test/models', class_path, "#{file_name}_test.rb")

      unless options[:skip_migration]
        m.migration_template 'model:migration.rb', 'db/migrate', :assigns => {
          :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
        }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
      end

    end
  end
end