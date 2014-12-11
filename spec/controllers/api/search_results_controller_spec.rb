require 'rails_helper'
describe API::SearchResultsController do

  let(:user)    { create :user }
  let(:group)   { create :group }
  let(:find_me) { create :discussion, group: group, title: 'find_me_title', description: 'find_me_desc' }
  let(:miss_me) { create :discussion, group: group, title: 'miss_me_title', description: 'miss_me_desc' }
  let(:motion_parent)  { create :discussion, group: group, title: 'nondescript', description: 'nondescript'}
  let(:find_me_motion) { create :motion, discussion: motion_parent, name: 'find_me_motion_title', description: 'find_me_motion_title'}

  describe 'index' do
    before do
      group.admins << user
      sign_in user
      find_me; miss_me; find_me_motion
    end

    it "filters by discussion" do
      get :index, q: 'find', format: :json
      json = JSON.parse(response.body)
      expect(json.keys).to include *(%w[discussions proposals])
      motion_ids = json['proposals'].map { |v| v['id'] }
      discussion_ids = json['discussions'].map { |v| v['id'] }
      expect(motion_ids).to include find_me_motion.id
      expect(discussion_ids).to include find_me.id
      expect(discussion_ids).to include motion_parent.id
      expect(discussion_ids).to_not include miss_me.id
    end
  end
end