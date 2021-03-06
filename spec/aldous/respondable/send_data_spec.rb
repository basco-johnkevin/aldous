RSpec.describe Aldous::Respondable::SendData do
  class Aldous::Respondable::SendData::Dummy < described_class
    def data
      'hello'
    end

    def options
      'world'
    end
  end

  subject(:send_data) {Aldous::Respondable::SendData::Dummy.new(status, view_data, view_context)}

  let(:status) {:foo}
  let(:view_data) {double("view_data")}
  let(:view_context) {double("view context")}

  describe "::action" do
    let(:controller) {double("controller")}

    it "returns a send_data response action object" do
      expect(send_data.action(controller)).to be_kind_of Aldous::Respondable::SendData::SendDataAction
    end

    it 'creates a send_data response action with the relevant parameters' do
      expect(Aldous::Respondable::SendData::SendDataAction).to receive(:new).with(send_data.data, send_data.options, controller, view_data)
      send_data.action(controller)
    end
  end
end
