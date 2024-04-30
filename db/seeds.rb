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
    EmployeeTeam.create(
        employee: employee,
        team: team
    )



  end

end
