# frozen_string_literal: true

RSpec.describe 'ConfigSchemaValidator', type: [:dry_validation] do
  subject(:schema_class) do
    Class.new(Dry::Validation::Schema) do
      define! do
        required('name').filled(:str?)
        required('base_url').filled(:str?)
        optional('status_endpoint').filled(:str?)
        optional('http_verb').value(included_in?: %w[get post])
      end
    end
  end

  it { is_expected.to validate(:name, :required).filled }
  it { is_expected.to validate(:base_url, :optional).filled }
  it { is_expected.to validate(:status_endpoint, :optional) }
  it { is_expected.to validate(:http_verb, :optional).value(included_in: %w[get post]) }
end
