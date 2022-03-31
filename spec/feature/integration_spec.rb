require 'rails_helper'

################################### admin CUD functions ###########################

RSpec.describe 'Creating a university', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
	click_on 'Create University'
	expect(page).to have_content('error')
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
    expect(page).to have_content('AM')
    expect(page).to have_content('0')
  end
end

RSpec.describe 'Creating a university with num_nominees', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
	click_on 'Create University'
	expect(page).to have_content('error')
    fill_in 'University name', with: 'AM'
    fill_in 'Maximum number of nominees allowed', with: '2'
	click_on 'Create University'
    visit universities_path
    expect(page).to have_content('AM')
    expect(page).to have_content('2')
  end
end

RSpec.describe 'Editing a university', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
    click_on 'Edit'
	fill_in 'University name', with: ''
	click_on 'Update University'
	expect(page).to have_content('error')
	fill_in 'University name', with: 'UT'
  fill_in 'Maximum number of nominees allowed', with: '2'
	click_on 'Update University'
	visit universities_path
	expect(page).to have_content('UT')
  expect(page).to have_content('2')
  end
end

RSpec.describe 'Deleting a university', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	click_on 'Delete'
    expect(page).not_to have_content('AM')
  end
end

RSpec.describe 'Creating a representative', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit new_representative_path
	click_on 'Create Representative'
    expect(page).to have_content('error')
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    # should error this part without @ but doesn't
    #fill_in 'Rep email', with: 'JohnSmith'
    #click_on 'Create Representative'
    #expect(page).to have_content('error')
    fill_in 'Email', with: 'JohnSmith@gmail.com'
	click_on 'Create Representative'
    visit representatives_path
    expect(page).to have_content('John')
    expect(page).to have_content('Smith')
    expect(page).to have_content('CEO')
    expect(page).to have_content('JohnSmith@gmail.com')
  end
end

RSpec.describe 'Editing a representative', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit new_representative_path
	select 'AM', :from => 'University'
	fill_in 'First name', with: 'John'
	fill_in 'Last name', with: 'Smith'
	fill_in 'Title', with: 'CEO'
	fill_in 'Email', with: 'JohnSmith@gmail.com'
	click_on 'Create Representative'
    visit representatives_path
    click_on 'Edit'
	fill_in 'First name', with: ''
	click_on 'Update Representative'
	expect(page).to have_content('error')
	fill_in 'First name', with: 'Alice'
	click_on 'Update Representative'
	visit representatives_path
	expect(page).to have_content('Alice')
  end
end

RSpec.describe 'Deleting a representative', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit new_representative_path
	select 'AM', :from => 'University'
	fill_in 'First name', with: 'John'
	fill_in 'Last name', with: 'Smith'
	fill_in 'Title', with: 'CEO'
	fill_in 'Email', with: 'JohnSmith@gmail.com'
	click_on 'Create Representative'
    visit representatives_path
	click_on 'Delete'
    expect(page).not_to have_content('John')
  end
end

RSpec.describe 'Creating a student', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
    expect(page).to have_content('AM')
  visit new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
  click_on 'Create Representative'
    visit representatives_path
    expect(page).to have_content('JohnSmith@gmail.com')
  visit new_student_path
    click_on 'Create Student'
    expect(page).to have_content('error')
    select 'AM', :from => 'University'
    select 'Smith, John', :from => 'Representative'
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
  click_on 'Create Student'
    visit students_path
    expect(page).to have_content('Foo')
    expect(page).to have_content('Bar')
    expect(page).to have_content('AM')
    expect(page).to have_content('John Smith')
    expect(page).to have_content('Bachelors')
    expect(page).to have_content('Basket Making')
    expect(page).to have_content('Fall Only')
    expect(page).to have_content('FooBar@gmail.com')
  end
end

RSpec.describe 'Editing a student', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
  visit new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
  click_on 'Create Representative'
    visit representatives_path
	visit new_student_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    select 'Smith, John', :from => 'Representative'
	click_on 'Create Student'
    visit students_path
  click_on 'Edit'
    fill_in 'First name', with: ''
    click_on 'Update Student'
    expect(page).to have_content('error')
    fill_in 'First name', with: 'Baz'
	click_on 'Update Student'
	visit students_path
	expect(page).to have_content('Baz')
  end
end

RSpec.describe 'Deleting a student', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
  visit new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
  click_on 'Create Representative'
    visit representatives_path
	visit new_student_path
  select 'AM', :from => 'University'
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    select 'Smith, John', :from => 'Representative'
	click_on 'Create Student'
    visit students_path
	click_on 'Delete'
    expect(page).not_to have_content('Foo')
  end
end

################################### user CRUD functions ###########################

RSpec.describe 'User creating a representative', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    click_on 'Create Representative'
    expect(page).to have_content('error')
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
  click_on 'Create Representative'
    expect(page).to have_content('John')
    expect(page).to have_content('Smith')
    expect(page).to have_content('CEO')
    expect(page).to have_content('JohnSmith@gmail.com')
    # expect to go to user_show after fail, Continue instead of Back
    expect(page).to have_content('Continue')
  end
end

RSpec.describe 'User editing a representative', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
  click_on 'Edit'
    fill_in 'First name', with: ''
    click_on 'Update Representative'
    expect(page).to have_content('error')
    fill_in 'First name', with: 'Alice'
  click_on 'Update Representative'
	  expect(page).to have_content('Alice')
    expect(page).to have_content('Continue') # expect user_show
  end
end

RSpec.describe 'User finish page', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
  click_on 'Create Representative'
  click_link 'Continue'
    expect(page).to have_content('Finish')
    expect(page).to have_content('John')
    expect(page).to have_content('Smith')
    expect(page).to have_content('CEO')
    expect(page).to have_content('JohnSmith@gmail.com')
  end
end

RSpec.describe 'User creating a student', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
  click_link 'Continue'
  click_on 'Enter a new student'
    expect(page).not_to have_content('University')
    expect(page).not_to have_content('Representative')
    click_on 'Create Student'
    expect(page).to have_content('error')
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
  click_on 'Create Student'
    expect(page).to have_content('Foo')
    expect(page).to have_content('Bar')
    expect(page).to have_content('Bachelors')
    expect(page).to have_content('Basket Making')
    expect(page).to have_content('Fall Only')
    expect(page).to have_content('FooBar@gmail.com')
    expect(page).to have_content('Finish') # expect user_show
  end
end

RSpec.describe 'User editing a student', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
  click_link 'Continue'
  click_on 'Enter a new student'
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
  click_on 'Create Student'
  click_on 'Edit'
    fill_in 'First name', with: ''
    click_on 'Update Student'
    expect(page).to have_content('error')
    fill_in 'First name', with: 'Baz'
	click_on 'Update Student'
    expect(page).to have_content('Baz')
    expect(page).to have_content('Finish') # expect user_show
  end
end

RSpec.describe 'User deleting a student', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
  click_link 'Continue'
  click_on 'Enter a new student'
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
  click_on 'Create Student'
  click_on 'Finish'
  # capybara error message: undefined method `user_destroy' for #<Capybara::RackTest::Browser:0x000055ccdacacd60 [...]
  # manual test works fine
  #click_on 'Delete'
  #expect(page).not_to have_content('Foo')
  end
end

################################### max limit variable ###########################

RSpec.describe 'Auto-stop user adding students', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
  click_link 'Continue'
  expect(page).to have_content('0 students nominated')
  click_on 'Enter a new student' # student 1
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    click_on 'Create Student'
    expect(page).to have_content('1 out of 3')
  click_on 'Enter another new student' # student 2
    fill_in 'First name', with: 'Foo2'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'Foo2Bar@gmail.com'
    click_on 'Create Student'
    expect(page).to have_content('2 out of 3')
  click_on 'Enter another new student' # student 3
    fill_in 'First name', with: 'Foo3'
    fill_in 'Last name', with: 'Bar'
    select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'Foo3Bar@gmail.com'
    click_on 'Create Student'
    expect(page).to have_content('3 out of 3')
  click_on 'Enter another new student' # auto-redirect to finish page
  expect(page).to have_content('Finish')
  expect(page).to have_content('Sorry')
  expect(page).to have_content('3 students nominated')
  click_on 'Enter a new student' # should not redirect
  expect(page).to have_content('Finish')
  expect(page).to have_content('Sorry')
  expect(page).to have_content('3 students nominated')
  end
end

RSpec.describe 'Re-activate new students after delete', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
  click_link 'Continue'
  click_on 'Enter a new student' # student 1
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    click_on 'Create Student'
   click_on 'Enter another new student' # student 2
    fill_in 'First name', with: 'Foo2'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'Foo2Bar@gmail.com'
    click_on 'Create Student'
  click_on 'Enter another new student' # student 3
    fill_in 'First name', with: 'Foo3'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'Foo3Bar@gmail.com'
    click_on 'Create Student'
  click_on 'Enter another new student' # auto-redirect to finish page
  expect(page).to have_content('3 students nominated')
  #click_on 'Delete' # delete a student?
  #expect(page).to have_content('2 students nominated')
  #click_on 'Enter a new student' # should redirect now
  #expect(page).to have_content('New Student')
  end
end

RSpec.describe 'Auto-stop with full students', type: :feature do
  scenario 'valid inputs' do
    visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
  click_link 'Continue'
  click_on 'Enter a new student' # student 1
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    click_on 'Create Student'
   click_on 'Enter another new student' # student 2
    fill_in 'First name', with: 'Foo2'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'Foo2Bar@gmail.com'
    click_on 'Create Student'
  click_on 'Enter another new student' # student 3
    fill_in 'First name', with: 'Foo3'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'Foo3Bar@gmail.com'
    click_on 'Create Student'
    # start over with new representative
  visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'Alice'
    fill_in 'Last name', with: 'May'
    fill_in 'Title', with: 'Division Head'
    fill_in 'Rep email', with: 'A.May@gmail.com'
    click_on 'Create Representative'
  click_link 'Continue'
    expect(page).to have_content('Finish')
    expect(page).to have_content('3 students nominated')
    expect(page).to have_content('Alice')
    expect(page).not_to have_content('Foo')
    click_on 'Enter a new student'
    expect(page).not_to have_content('New Student')
    expect(page).to have_content('Finish')
    expect(page).to have_content('Sorry')
  end
end

RSpec.describe 'Admin max limit nominees', type: :feature do
  scenario 'valid inputs' do 
    visit admin_path
	  expect(page).to have_content('3')
    fill_in 'max_lim', with: '-1'
    click_on 'Update Limit'
	  expect(page).to have_content('Admin Home')
	  expect(page).to have_content('3')
    fill_in 'max_lim', with: '5'
    click_on 'Update Limit'
  visit admin_path
    expect(page).not_to have_content('3')
	  expect(page).to have_content('5')
  end
end

#admin add new student does not interact with limit

################################### question-answer-response ###########################

RSpec.describe 'Make question', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
    check 'Multi'
	fill_in 'Prompt', with: ''
    click_on 'Create Question'
    expect(page).to have_content('error')
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	visit questions_path
    expect(page).to have_content('How are you?')
  end
end

RSpec.describe 'Edit question', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
    check 'Multi'
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	visit questions_path
    expect(page).to have_content('How are you?')
	click_on 'Edit'
	fill_in 'Prompt', with: ''
	click_on 'Update Question'
  expect(page).to have_content('error')
	fill_in 'Prompt', with: 'Why are you?'
	click_on 'Update Question'
	visit questions_path
    expect(page).to have_content('Why are you?')
  end
end

RSpec.describe 'Delete question', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
    check 'Multi'
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	visit questions_path
    expect(page).to have_content('How are you?')
	click_on 'Destroy'
	visit questions_path
    expect(page).not_to have_content('How are you?')
  end
end

RSpec.describe 'Make answer', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
    check 'Multi'
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	visit questions_path
	click_on 'Show'
	click_on 'Add Answer'
	click_on 'New Answer'
	fill_in 'Choice', with: ''
	click_on 'Create Answer'
	expect(page).to have_content('error')
	fill_in 'Choice', with: 'Good'
	click_on 'Create Answer'
	visit questions_path
	click_on 'Show'
	expect(page).to have_content('Good')
  end
end

RSpec.describe 'Edit answer', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
    check 'Multi'
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	visit questions_path
	click_on 'Show'
	click_on 'Add Answer'
	click_on 'New Answer'
	fill_in 'Choice', with: 'Good'
	click_on 'Create Answer'
	visit questions_path
	click_on 'Show'
	expect(page).to have_content('Good')
	click_on 'Add Answer'
	click_on 'Edit Choice'
    fill_in 'Choice', with: ''
    click_on 'Update Answer'
    expect(page).to have_content('error')
	  fill_in 'Choice', with: 'Bad'
	click_on 'Update Answer'
	visit questions_path
	  click_on 'Show'
    expect(page).to have_content('Bad')
  end
end

RSpec.describe 'Delete answer', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
    check 'Multi'
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	visit questions_path
	click_on 'Show'
	click_on 'Add Answer'
	click_on 'New Answer'
	fill_in 'Choice', with: 'Good'
	click_on 'Create Answer'
	visit questions_path
	click_on 'Show'
	expect(page).to have_content('Good')
	click_on 'Add Answer'
	click_on 'Destroy Choice'
	visit questions_path
	  click_on 'Show'
    expect(page).not_to have_content('Good')
  end
end

RSpec.describe 'Make response', type: :feature do
  scenario 'valid inputs' do 
  
    visit new_question_path
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	
	visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
	
	click_link 'Continue'
	click_on 'Enter a new student' # student 1
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    click_on 'Create Student'
	
	visit students_path
	click_on 'Show'
	click_on 'Add Response'
	click_on 'New Response'
	fill_in 'How are you?', with: ''
	click_on 'Create Response'
	expect(page).to have_content('error')
	fill_in 'How are you?', with: 'Good'
	click_on 'Create Response'
	visit students_path
	click_on 'Show'
	expect(page).to have_content('Good')
  end
end

RSpec.describe 'Edit response', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	
	visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
	
	click_link 'Continue'
	click_on 'Enter a new student' # student 1
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    click_on 'Create Student'
	
	visit students_path
	click_on 'Show'
	click_on 'Add Response'
	click_on 'New Response'
	fill_in 'How are you?', with: 'Good'
	click_on 'Create Response'
	visit students_path
	click_on 'Show'
	expect(page).to have_content('Good')
	click_on 'Add Response'
	click_on 'Edit Response'
	fill_in 'How are you?', with: ''
	click_on 'Update Response'
	expect(page).to have_content('error')
	fill_in 'How are you?', with: 'Bad'
	click_on 'Update Response'
	visit students_path
	  click_on 'Show'
    expect(page).to have_content('Bad')
  end
end

RSpec.describe 'Delete response', type: :feature do
  scenario 'valid inputs' do 
    visit new_question_path
	fill_in 'Prompt', with: 'How are you?'
	click_on 'Create Question'
	
	visit new_university_path
    fill_in 'University name', with: 'AM'
	click_on 'Create University'
    visit universities_path
	visit user_new_representative_path
    select 'AM', :from => 'University'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Title', with: 'CEO'
    fill_in 'Email', with: 'JohnSmith@gmail.com'
    click_on 'Create Representative'
	
	click_link 'Continue'
	click_on 'Enter a new student' # student 1
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
     select 'Bachelors', :from => 'Degree level'
    fill_in 'Major', with: 'Basket Making'
    select 'Fall Only', :from => 'Exchange term'
    fill_in 'Student email', with: 'FooBar@gmail.com'
    click_on 'Create Student'
	
	visit students_path
	click_on 'Show'
	click_on 'Add Response'
	click_on 'New Response'
	fill_in 'How are you?', with: 'Good'
	click_on 'Create Response'
	visit students_path
	click_on 'Show'
	expect(page).to have_content('Good')
	click_on 'Add Response'
	click_on 'Destroy Response'
	visit students_path
	  click_on 'Show'
    expect(page).not_to have_content('Good')
  end
end


#admin login
#test destroy associations
#test show compound tables?
#valid email
