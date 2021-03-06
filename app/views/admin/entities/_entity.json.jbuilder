json.extract! entity, :id, :template_id, :slug, :data, :created_at, :updated_at, :published_at, :generated_fields

json.published entity.published

entity.data.each do |key, value|
  json.set! key, value
end

json.permissions entity_permissions(entity)

json.url pretty_workspace_template_entity_url(@workspace, @template, entity, format: :json)
