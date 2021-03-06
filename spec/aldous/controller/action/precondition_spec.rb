RSpec.describe Aldous::Controller::Action::Precondition do
  before do
    class ExamplePrecondition < Aldous::Controller::Action::Precondition
    end
  end

  after do
    Object.send :remove_const, 'ExamplePrecondition'
  end

  let(:precondition) {ExamplePrecondition.new(action, controller, view_builder)}

  let(:action) {double 'action', controller: controller, default_view_data: default_view_data}
  let(:controller) {double 'controller', view_context: view_context}
  let(:view_builder) {double 'view_builder'}
  let(:view_context) {double "view_context"}
  let(:default_view_data) {double "default_view_data"}

  describe "::build" do
    before do
      allow(ExamplePrecondition).to receive(:new).and_return(precondition)
      allow(Aldous::Controller::Action::Precondition::Wrapper).to receive(:new)
    end

    it "wraps a controller action instance" do
      expect(Aldous::Controller::Action::Precondition::Wrapper).to receive(:new).with(precondition)
      ExamplePrecondition.build(action, controller, view_builder)
    end
  end

  describe "::perform" do
    let(:wrapper) {double "wrapper", perform: nil}

    before do
      allow(ExamplePrecondition).to receive(:new).and_return(action)
      allow(Aldous::Controller::Action::Precondition::Wrapper).to receive(:new).and_return(wrapper)
    end

    it "calls perform on the wrapper" do
      expect(wrapper).to receive(:perform)
      ExamplePrecondition.perform(action, controller, view_builder)
    end
  end

  describe "::inherited" do
    context "a precondition instance" do
      Aldous.configuration.controller_methods_exposed_to_action.each do |method_name|
        it "responds to #{method_name}" do
          expect(precondition).to respond_to method_name
        end
      end
    end
  end

  describe "#perform" do
    it "raises an error since it should be overridden" do
      expect{precondition.perform}.to raise_error
    end
  end
end
