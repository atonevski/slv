require File.join(File.dirname(__FILE__), '/../spec_helper')
describe "HTTP access to issues" do 
  before(:each) do
    @http = SLV::HTTP.new
  end

  it "should successfully download existing issue" do
    @http.get_issue(Time.now.year, 1).should_not be_nil
  end
  it "should indicate if an issue does not exists" do
    @http.get_issue(2010, 0).should be_nil
  end
  it "should successfully retrive links for whole year" do
    @http.issues_for(2012).compact.size.should == 173
  end
end
