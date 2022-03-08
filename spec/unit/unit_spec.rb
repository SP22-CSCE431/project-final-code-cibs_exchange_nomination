require 'rails_helper'
require 'spec_helper'

RSpec.describe Representative, type: :model do
  subject do
    @uni = University.new(university_name: 'AM')
    @uni.save
    described_class.new(first_name: 'John', last_name: 'Smith', title: 'CEO', university_id: @uni.id, rep_email: 'JohnSmith@gmail.com')
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a first_name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a last_name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a university_id' do
    subject.university_id = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a rep_email' do
    subject.rep_email = nil
    expect(subject).not_to be_valid
  end
end

RSpec.describe University, type: :model do
  subject do
    described_class.new(university_name: 'AM')
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a university_name' do
    subject.university_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a num_nominees' do
    subject.num_nominees = nil
    expect(subject).not_to be_valid
  end
end

RSpec.describe University, type: :model do
  subject do
    described_class.new(university_name: 'AM', num_nominees: 0)
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a university_name' do
    subject.university_name = nil
    expect(subject).not_to be_valid
  end
end

RSpec.describe Student, type: :model do
  subject do
    @uni = University.new(university_name: 'AM')
    @uni.save
    @rep = Representative.new(first_name: 'John', last_name: 'Smith', title: 'CEO', university_id: @uni.id, rep_email: 'JohnSmith@gmail.com')
    @rep.save
    described_class.new(first_name: 'Foo', last_name: 'Bar', university_id: @uni.id, representative_id: @rep.id, student_email: 'FooBar@gmail.com', exchange_term: 'First', degree_level: 'PHD', major: 'Basket Making')
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a first_name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a last_name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a university_id' do
    subject.university_id = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a student_email' do
    subject.student_email= nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a exchange_term' do
    subject.exchange_term = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a degree_level' do
    subject.degree_level = nil
    expect(subject).not_to be_valid
  end
    
  it 'is not valid without a major' do
    subject.major = nil
    expect(subject).not_to be_valid
  end
end

RSpec.describe Question, type: :model do
  subject do
    described_class.new(multi: false, prompt: "How are you?")
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a prompt' do
    subject.prompt = nil
    expect(subject).not_to be_valid
  end
end

RSpec.describe Answer, type: :model do
  subject do
    @que = Question.new(multi: false, prompt: "How are you?")
    @que.save
    described_class.new(choice: "good", question_id: @que.id)
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a choice' do
    subject.choice = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a questipn' do
    subject.question_id = nil
    expect(subject).not_to be_valid
  end
end

RSpec.describe Response, type: :model do
  subject do
    @uni = University.new(university_name: 'AM')
    @uni.save
    @rep = Representative.new(first_name: 'John', last_name: 'Smith', title: 'CEO', university_id: @uni.id, rep_email: 'JohnSmith@gmail.com')
    @rep.save
    @stu = Student.new(first_name: 'Foo', last_name: 'Bar', university_id: @uni.id, representative_id: @rep.id, student_email: 'FooBar@gmail.com', exchange_term: 'First', degree_level: 'PHD', major: 'Basket Making')
    @stu.save
    @que = Question.new(multi: false, prompt: "How are you?")
    @que.save
    described_class.new(reply: "good", question_id: @que.id, student_id: @stu.id)
  end

  it 'is valid with all valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a reply' do
    subject.reply = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a question_id' do
    subject.question_id = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a student_id' do
    subject.student_id = nil
    expect(subject).not_to be_valid
  end
end