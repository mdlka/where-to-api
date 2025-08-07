class ApiKeyBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :created_at
end
