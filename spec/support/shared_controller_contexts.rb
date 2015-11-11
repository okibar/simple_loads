shared_context 'a successful request' do
  it { is_expected.to respond_with(200) }
end

shared_context 'a redirect' do
  it { is_expected.to respond_with(302) }
end

shared_context 'a create' do
  it { is_expected.to render_template(:create) }
end

shared_context 'a destroy' do
  it { is_expected.to render_template(:destroy) }
end

shared_context 'an edit' do
  it { is_expected.to render_template(:edit) }
end

shared_context 'an index' do
  it { is_expected.to render_template(:index) }
end

shared_context 'load index' do
  it { is_expected.to redirect_to(loads_path) }
end

shared_context 'a new' do
  it { is_expected.to render_template(:new) }
end

shared_context 'a show' do
  it { is_expected.to render_template(:show) }
end
