Fabricator :user_challenge do
  user do
    Fabricate :user
  end

  challenge do
    Fabricate :challenge
  end
end

Fabricator :challenge do
  user do
    Fabricate :user
  end

  name do
    Fabricate.sequence(:name){|i| "Challenge #{i}"}
  end

  segment_id do
    Fabricate.sequence(:segment_id) { |i| i }
  end

  segment_name do
    Fabricate.sequence(:segment_name){|i| "Segment #{i}"}
  end

  end_time do
    Time.now + 2.days
  end
end

Fabricator :user do
  name do
    Fabricate.sequence(:name){|i| "User #{i}"}
  end

  email do
    Fabricate.sequence(:email) { |i| "email-#{i}@example.com" }
  end

  profile_picture_url do
    Fabricate.sequence(:profile_picture_url) { |i| "http://example.com/#{i}.jpg" }
  end

  uid do
    Fabricate.sequence(:uid) { |i| i }
  end

  provider :strava
end
