json.extract! template, :id, :workspace_id, :name, :plural, :slug, :fields, :publishable, :sluggable_field, :created_at, :updated_at

json.url workspace_template_url(template.workspace, template, format: :json)