require "faker"


job_titles_list = [
  "Associate Software Engineer",
  "Software Engineer",
  "Senior Software Engineer",
  "Lead Software Engineer",
  "Associate Software Quality Engineer",
  "Software Quality Engineer",
  "Senior Software Quality Engineer",
  "Lead Software Quality Engineer",
  "Business Analyst",
  "Technology Delivery Director",
  "Scrum Master",
  "Agile Product Owner"
]

job_titles_list.each do |title|
  JobTitle.create(title: title)
end

# Seed teams
teams = []
6.times do
  teams << Team.create(name: Faker::Team.name)
end

# Seed employees with unique job titles for each team
teams.each do |team|
  12.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    title = JobTitle.all.sample
    employee = Employee.create(
      first_name: first_name,
      last_name: last_name,
      
      job_title: title
    )
    max_future_date = Date.today + 1.year

    start_date_range = (6.months.ago.to_date..Date.yesterday)
    
    if rand(2).zero?
      # Set an end date within the range
      end_date = (5.months.ago.to_date..max_future_date).to_a.sample
    else
      # Set no end date
      end_date = nil
    end
    
    EmployeeTeam.create(
      employee: employee,
      team: team,
      start_date: start_date_range.to_a.sample,
      end_date: end_date
    )

  end

end
