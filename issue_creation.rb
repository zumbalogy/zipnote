project = Project.where(name: 'clemintinie').first
release = project.releases.last
account = project.account

user = account.user

image = File.new(Rails.root.to_s + '/spec/fixtures/issues/rails.png')

cases = release.release_test_cases


def add_issue(release_test_case, account, release, project, image, user)
  issue = Issue.new(account: account, project: project, release: release, user: user)
  issue.state = ['finished', 'passed'].sample
  issue.device = Device.new(uuid: UUID.generate, app_uuid: UUID.generate, name: ('a'..'z').to_a.sample, account: account, user_id: user.id)
  Markup.create(image: image, user: user, issue: issue)
  issue.release_test_case = release_test_case
  issue.save!
  release_test_case.save!
end


c = cases.sample; add_issue(c, account, release, project, image, user)

