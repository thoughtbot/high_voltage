['4.0.0.rc1', '3.2.13', '3.1.12', '3.0.20'].each do |rails_version|
  appraise "rails_#{rails_version}" do
    gem "rails", rails_version
    if rails_version == '4.0.0.rc1'
      gem "actionpack-action_caching"
      gem "actionpack-page_caching"
    end
  end
end
